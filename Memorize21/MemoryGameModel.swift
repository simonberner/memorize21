// Fondation contains: String, Array, Dictionary etc.
import Foundation

// This is a Model of MVVM
struct MemoryGameModel<CardContent> {
    // private(set): the EmojiMemoryGameViewModel shall not be able to change the cards
    // for that we have the func choose below
    private(set) var cards: Array<Card>
    
    // the external name of the argument is blank _
    // the internal name of the argument is then card
    func choose(_ card: Card) {
        
    }
    
    // free init is lots with this init
    // second argument must be a function with an argument (Int) pairIndex which returns a something of type CardContent
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfParisOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card( content: content))
            cards.append(Card( content: content))

        }
    }
    
    // MemoryGameModel.Card
    // If taken outside, it would no longer be bound to the name of MemoryGameModel in case there
    // is another model (e.g. Poker) which also has a type Card.
    // By nesting it like here, we define that the Card belongs to the MemoryGameModel!
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // this is a made up don't care (generics)
    }
}
