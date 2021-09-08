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
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else {
                    // Assignment2 - ExtraCredit3
                    shape.fill(LinearGradient(
                                gradient: gameViewModel.emojiThemeColorGradient,
                                startPoint: .leading,
                                endPoint: .topTrailing))
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    // for drawing we use CGFloat, not Int or Double!
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}






























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let gameViewModel = EmojiMemoryGameViewModel()
        EmojiMemoryGameView(gameViewModel: gameViewModel)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(gameViewModel: gameViewModel)
            .preferredColorScheme(.light)
    }
}
