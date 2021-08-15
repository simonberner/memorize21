// Fondation contains: String, Array, Dictionary etc.
import Foundation

// This is a Model of MVVM
struct MemoryGameModel<CardContent> {
    // private(set): the EmojiMemoryGameViewModel shall not be able to change the cards
    // for that we have the func choose below
    private(set) var cards: Array<Card>
    
    // the external name of the argument is blank _
    // the internal name of the argument is then card
    // (all arguments to functions are lets)
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
        print("all cards = \(cards)")
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0
    }
    
    // free init gets lost with this init
    // second argument must be a function with an argument (Int) pairIndex which returns a something of type CardContent
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfParisOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card( content: content, id: pairIndex*2))
            cards.append(Card( content: content, id: pairIndex*2+1))

        }
    }
    
    // MemoryGameModel.Card
    // If taken outside, it would no longer be bound to the name of MemoryGameModel in case there
    // is another model (e.g. Poker) which also has a type Card.
    // By nesting it like here, we define that the Card belongs to the MemoryGameModel!
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent // this is a made up don't care (generics)
        var id: Int // Int type but also could be UUID
    }
}
