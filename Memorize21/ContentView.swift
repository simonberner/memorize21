import SwiftUI

// this is all functional programming
// (there is no shared state, mutable data or other side effects)
// (application state flows through pure functions)
// (see also https://medium.com/javascript-scene/master-the-javascript-interview-what-is-functional-programming-7f218c68b3a0)
// View which reflect the model
struct ContentView: View {
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
            
            ScrollView {
                    // Lazy about accessing the body vars in the view
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        // \.self means: use the emoji String itself as identifier
                        // the emoji is just the argument to the closure
                        ForEach(gameViewModel.cards) { card in
                            CardView(card: card, gameViewModel: gameViewModel)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    gameViewModel.choose(card)
                                }
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
    let card: MemoryGameModel<String>.Card
    let gameViewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                // Assignment2 - ExtraCredit3
                shape.fill(LinearGradient(
                            gradient: gameViewModel.emojiThemeColorGradient,
                                startPoint: .leading,
                                endPoint: .topTrailing))
            }
        }
    }
}






























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let gameViewModel = EmojiMemoryGameViewModel()
        ContentView(gameViewModel: gameViewModel)
            .preferredColorScheme(.dark)
        ContentView(gameViewModel: gameViewModel)
            .preferredColorScheme(.light)
    }
}
