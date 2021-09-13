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
            
            AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3) { card in
                // this is a valid view builder: if else returns a view in any case
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card, gameViewModel: gameViewModel)
                        .padding(4)
                        .onTapGesture {
                            gameViewModel.choose(card)
                        }
                }
            }
            .foregroundColor(gameViewModel.emojiThemeColor)
            .padding(.horizontal)
            Button(action: {
                gameViewModel.startNewGame()
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
                Text(card.content).font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, cardColor: gameViewModel.emojiThemeColorGradient)
        })
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
    }
}






























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let gameViewModel = EmojiMemoryGameViewModel()
        gameViewModel.choose(gameViewModel.cards.first!)
        return EmojiMemoryGameView(gameViewModel: gameViewModel)
//        EmojiMemoryGameView(gameViewModel: gameViewModel)
//            .preferredColorScheme(.dark)
//        EmojiMemoryGameView(gameViewModel: gameViewModel)
//            .preferredColorScheme(.light)
    }
}
