import SwiftUI

// This is a ViewModel of MVVM
// It is always a class because we want to share an instance of it with different views at the same time!
// The ViewModel is the gatekeeper and its job is to protect the Model against odd behaving views
// (remember: classes are mutable, this is a pro and con because anyone who has a pointer to the same
// instance or var of a class, can change it!)
class EmojiMemoryGameViewModel: ObservableObject {
    
    // must behave like an Identifiable, that is why we use itself \.self as identifier
    // static: global constant (type constant)
    static let emojis = ["🚖","🛥","✈️","🚀","🚗","🚊","🚟","🛶","🛫","🚜","🏎","🏍","🛵","🚐","🚤","🛴","🚲","⛵️","🚠","🚌","🦽","🛸","🏍","🚢"]
    
    // this is a type function because it is static and belongs to the class (global scope) and not an instance of it
    static func createMemoryGame() -> MemoryGameModel<String> {
        // as 2nd argument we just pass in a closure with a argument 'pairIndex' and a smiley as return value (CardContent) (1:23:15 - lecture 3)
        // createCardContent closure: pairIndex 'in' is to separate the argument from the body3e
        MemoryGameModel<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // access control - private(set): other structs/classes can look at the model, but can't change it
    @Published private var model: MemoryGameModel<String> = createMemoryGame()
     
    
    // to make the model fully private and make it available:
    // this is completely read only
    // var who's value is calculated by a function (return model.cards)
    // as an array is a struct, this the function returns a fresh copy of model.cards each time
    var cards: Array<MemoryGameModel<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
    
}
