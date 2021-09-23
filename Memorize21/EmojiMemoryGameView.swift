import SwiftUI

// this is all functional programming
// (there is no shared state, mutable data or other side effects)
// (application state flows through pure functions)
// (see also https://medium.com/javascript-scene/master-the-javascript-interview-what-is-functional-programming-7f218c68b3a0)
// View which reflect the model
struct EmojiMemoryGameView: View {
    // we would probably better name that var 'game/memoryGame', but for
    // learning purposes (to better see which is the viewModel) we call it gameViewModel
    // (when an ObservedObject changes, the entire body of a view gets automatically redrawn!)
    @ObservedObject var gameViewModel: EmojiMemoryGameViewModel
    
    // the view who draws the model
    var body: some View {
        VStack {
            HStack {
                Text(gameViewModel.emojiThemeName)
                    .font(.title)
                Spacer()
                Text("Score: \(gameViewModel.score)")
            }
            .padding()
            gameBody
            newGameButton
        }
    }
    
    // keep track of dealt (laid out) cards
    // (temporary state in this view)
    @State private var dealt = Set<Int>() // things in a Set are unique
    
    private func deal(_ card: EmojiMemoryGameViewModel.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGameViewModel.Card) -> Bool {
        !dealt.contains(card.id) // a card is undealt if it is NOT already in the Set
    }
    
    private var gameBody: some View {
        AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3) { card in
            // this is a valid view builder: if else returns a view in any case
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear // behaves like a view here and creates a rectangle with the color 'clear'
            } else {
                CardView(card: card, gameViewModel: gameViewModel)
                    .padding(4)
                    // different transition for in and out with the static func asymmetric
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut(duration: 2)))
                    .onTapGesture {
                        withAnimation {
                            gameViewModel.choose(card)
                        }
                    }
            }
        }
        // put a view on screen after its container is on screen
        // when in this case the container view AspectVGrid appears
        // the func withAnimation is performed
        .onAppear{
            // deal the cards out
            // withAnimation go through all my cards
            withAnimation {
                for card in gameViewModel.cards {
                    deal(card)
                }
            }
        }
        .foregroundColor(gameViewModel.emojiThemeColor)
        .padding(.horizontal)
    }
    
    private var newGameButton: some View {
        Button(action: {
            // all view modifiers which can be animated are being animated inclusive those from
            // the gameBody's AspectVGrid which are needed to position the cards
            // explicit animations are mostly used for 'user intent' functions to animate change
            // in the ui
            withAnimation{
                gameViewModel.startNewGame()
            }
        }, label: {
            HStack {
                Image(systemName: "restart.circle")
                Text("New Game")
                    .fontWeight(.semibold)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(40)
        })
        .accessibility(label: Text("NewGame"))
    }
}

// every view in SwiftUI is immutable (can't be modified)
// 'self' here is the whole CardView
// the view is constantly rebuild when something changes in view
struct CardView: View {
    let card: EmojiMemoryGameViewModel.Card
    let gameViewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        // GeometryReader offers space to its sub-views by telling them
        // how much space they have
        GeometryReader (content: { geometry in
            ZStack {
                // 0 degrees is to the right of the iOS coordinate system (x:0/y:0 in the upper left)
                // that is why we have to subtract 90deg (when thinking in compass rose https://en.wikipedia.org/wiki/Compass_rose)
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(DrawingConstants.piePadding)
                    .opacity(DrawingConstants.pieOpacity)
                Text(card.content)
//                    .font(font(in: geometry.size)) // font is NOT animatable
                    // animations animate changes on screen
                    // the arguments to a view modifier need to change in order that
                    // the view modifier can be animated
                    // it is already rotating when coming on screen
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0)) // this is now animatable
                    // implicit animation which only animates the view modifier above
                    // so the placement of implicit animation modifiers is important
                    // this animation animates the change of the above var card.isMatched
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize)) // fixed font size which does not have to animate
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            // the ZStack is passed as content to the Cardify ViewModifier
            .cardify(isFaceUp: card.isFaceUp, cardColor: gameViewModel.emojiThemeColorGradient)
        })
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat{
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    // for drawing we use CGFloat, not Int or Double!
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let circleOpacity = 0.5 // inferred type is Double here
        static let piePadding: CGFloat = 5
        static let pieOpacity = 0.5 // inferred type is Double here
        static let fontSize: CGFloat = 32
    }
}






























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let gameViewModel = EmojiMemoryGameViewModel()
//        gameViewModel.choose(gameViewModel.cards.first!)
//        return EmojiMemoryGameView(gameViewModel: gameViewModel)
        EmojiMemoryGameView(gameViewModel: gameViewModel)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(gameViewModel: gameViewModel)
            .preferredColorScheme(.light)
    }
}
