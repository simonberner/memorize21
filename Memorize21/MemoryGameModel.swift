// Fondation contains: String, Array, Dictionary etc.
import Foundation

// This is a Model of MVVM
// CardContent behaves like an Equatable
struct MemoryGameModel<CardContent> where CardContent: Equatable {
    // private(set): the EmojiMemoryGameViewModel shall not be able to change the cards
    // for that we have the func choose below
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    // the external name of the argument is blank _
    // the internal name of the argument is then card
    // (all arguments to functions are lets)
    // mutating because it is changing the model itself
    mutating func choose(_ card: Card) {
        // we can replace the arguments names to a closure with $0,1,2
        // ($0.id: we are passing in a card's id in the cards array as argument to the closure)
        // first term will be executed and assigned to chosenIndex and then the second and third term
        // are executed where chosenIndex then is set
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                // turning all the cards face down
                // .indices: returns the range 0..<cards.count
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
            print("all cards = \(cards)")
        }
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // this is a made up don't care (generics)
        var id: Int // Int type but also could be UUID
    }
}
