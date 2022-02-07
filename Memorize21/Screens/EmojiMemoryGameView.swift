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
    // @Namespace creates an animation namespace to allow matched geometry effects, which can be shared by other views.
    @Namespace private var dealingNamespace

    // the view who draws the model
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                header
                gameBody
                HStack {
                    newGameButton
                    Spacer()
                }
                .padding(.horizontal)
            }
            deckBody
            infoView
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

    private func dealAnimation(for card: EmojiMemoryGameViewModel.Card) -> Animation {
        var delay = 0.0
        // firstIndex: returns the first index (Int) in the Array, where the id of a card in the cards Array
        // is equal to the id of the passed in card (card.id)
        if let index = gameViewModel.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(gameViewModel.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }

    // the higher numbers will be in the front and the lower numbers in the back (towards the device ;))
    // fyi: Views have a default Z index of 0, but you can provide positive or negative values that position
    // them on top of or below other views respectively.
    private func zIndex(of card: EmojiMemoryGameViewModel.Card) -> Double {
        -Double(gameViewModel.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }

    private var header: some View {
        HStack {
            Text(gameViewModel.emojiThemeName)
                .font(.title2)
            Spacer()
            Text("Score: \(gameViewModel.score)")
            Spacer()
            infoButton
        }
        .padding(.horizontal)
    }

    private var gameBody: some View {
        AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3) { card in
            // this is a valid view builder: if else returns a view in any case
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear // behaves like a view here and creates a rectangle with the color 'clear'
            } else {
                CardView(card: card, gameViewModel: gameViewModel)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    // different transition for in and out with: static func asymmetric
                    // .identity: don't scale it / don't do any animation
                    // here: use the above geometry effect when inserting a card and use the opacity transition
                    // when a card is removed
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            gameViewModel.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(gameViewModel.emojiThemeColor)
        .padding(.horizontal)
    }

    private var deckBody: some View {
        ZStack {
            // ForEach is another way to see views appearing and disappearing
            ForEach(gameViewModel.cards.filter(isUndealt)) { card in
                CardView(card: card, gameViewModel: gameViewModel)
                    // links the cards to the above gameBody cards
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(gameViewModel.emojiThemeColor)
        // put a view on screen after its container is on screen
        // when in this case the container view AspectVGrid appears
        // the func withAnimation is performed
        .onTapGesture {
            // deal the cards out
            // withAnimation go through all my cards
            for card in gameViewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }

    private var newGameButton: some View {
        Button(action: {
            // all view modifiers which can be animated are being animated inclusive those from
            // the gameBody's AspectVGrid which are needed to position the cards
            // explicit animations are mostly used for 'user intent' functions to animate change
            // in the ui
            withAnimation {
                dealt = [] // resetting it to empty causes animation to happen
                gameViewModel.startNewGame()
            }
        }, label: {
            HStack {
                Image(systemName: "restart.circle")
                Text("New Game")
            }
        })
        .accessibility(label: Text("NewGame"))
    }

    // here we associate a transition with the coming/going of the infoView on screen
    // a transition on its own has no effect, it must be associated with an animation
    private var infoView: some View {
        InfoView(isShowing: $showInfoView)
            // Implicit animations are animations that you specify using the .animation() modifier.
            // This method is used on bindings (here $showInfoView), and it asks SwiftUI to animate
            // any changes that result in the binding’s value being modified.
            .animation(.easeInOut(duration: 1), value: showInfoView)
            .transition(.asymmetric(insertion: .slide, removal: .slide))
    }

    // The @State property wrapper exposes a binding to its underlying value,
    // which we can get to via the $ prefix. For an @State property named swiftCount,
    // the name of the binding is $swiftCount. This is effectively a second property
    // that’s synthesized because of @State.
    // (https://learnappmaking.com/binding-swiftui-how-to/)
    @State private var showInfoView = false

    private var infoButton: some View {
        Button(action: {
            showInfoView = true
        }, label: {
            Image(systemName: "info.circle")
        })
    }

    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var theme: String?

    static var previews: some View {
        let gameViewModel = EmojiMemoryGameViewModel(selectedTheme: theme)
        EmojiMemoryGameView(gameViewModel: gameViewModel)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(gameViewModel: gameViewModel)
            .preferredColorScheme(.light)
    }
}
