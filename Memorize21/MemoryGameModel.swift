// Fondation contains: String, Array, Dictionary etc.
import Foundation

// This is a Model of MVVM
// CardContent behaves like an Equatable
struct MemoryGameModel<CardContent> where CardContent: Equatable {
    // private(set): the EmojiMemoryGameViewModel shall not be able to change the cards
    // for that we have the func choose below
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private var startDateOfFirstChosenCard: Date?
    
    private(set) var score = 0
    
    // the external name of the argument is blank _
    // the internal name of the argument is then card
    // (all arguments to functions are lets)
    // mutating because it is changing the model itself
    mutating func choose(_ card: Card) {
        // we can replace the arguments names to a closure with $0,1,2
        // ($0.id: we are passing in a card's id in the cards array as argument to the closure)
        // first term will be executed and assigned to chosenIndex and then the second and third term
        // are executed where chosenIndex then is set
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id }), // if the card is in the cards array
           !cards[chosenIndex].isFaceUp, // AND the card at the chosenIndex is not faceUp
           !cards[chosenIndex].isMatched // AND the card at the chosenIndex is not matched
        {
            // if 'potentialMatchIndex' is not nil (the second card is chosen)
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard { // computed property
                // if the content of the two cards (chosenIndex, potentialMatchIndex) are equal,
                // set the isMatched of the two cards to true
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                // calculate the score when two cards are chosen
                calculateScore(firstCard: cards[chosenIndex], secondCard: cards[potentialMatchIndex], startDate: startDateOfFirstChosenCard!)
                indexOfTheOneAndOnlyFaceUpCard = nil
                // else (if a card is facing up) turn it face down
                // and mark the card as already been seen
                // and set the chosenIndex for the current face-up card
            } else {
                // turning all the cards face down
                // .indices: returns the range 0..<cards.count
                // so for every card do:
                for index in cards.indices {
                    if cards[index].isFaceUp {
                        cards[index].isFaceUp = false
                        cards[index].hasAlreadyBeenSeen = true
                        cards[index].isFirstCard = false
                    }
                }
                // when first card is chosen we jump right here
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                cards[chosenIndex].isFirstCard = true
            }
            cards[chosenIndex].isFaceUp.toggle()
            if cards[chosenIndex].isFirstCard {
                startDateOfFirstChosenCard = Date()
                print("1st card get chosen at: \(startDateOfFirstChosenCard ?? Date())")
                cards[chosenIndex].isFirstCard = false
            }
            print("all cards = \(cards)")
        }
    }
    
    // Scoring system:
    // Gives more(for a match) or less (for a mismatch) points when choosing the 2nd card more quickly (based on the time difference in seconds)
    mutating func calculateScore(firstCard: Card, secondCard: Card, startDate: Date) {
        let endDate = Date()
        print("2nd card get chosen at: \(endDate)")

        // https://developer.apple.com/documentation/foundation/timeinterval
        // diffInSeconds: Double
        let diffInSeconds = endDate.timeIntervalSince(startDate).rounded()
        print("2nd card get chosen \(diffInSeconds) seconds later")

        if firstCard.content == secondCard.content {
            score += max(10 - Int(diffInSeconds), 1) * 2
        } else {
            if firstCard.hasAlreadyBeenSeen || secondCard.hasAlreadyBeenSeen {
                score -= max(10 - Int(diffInSeconds), 1)
            }
        }
    }
    
    // free init gets lost with this init
    // second argument must be a function with an argument (Int) pairIndex which returns a something of type CardContent
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [] // Swift can infer the type here from the above declaration
        // add numberOfParisOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card( content: content, id: pairIndex*2))
            cards.append(Card( content: content, id: pairIndex*2+1))

        }
        cards.shuffle() // Assignment2 - Task13
    }
    
    // MemoryGameModel.Card
    // If taken outside, it would no longer be bound to the name of MemoryGameModel in case there
    // is another model (e.g. Poker) which also has a type Card.
    // By nesting it like here, we define that the Card belongs to the MemoryGameModel!
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var isFirstCard = false
        var hasAlreadyBeenSeen = false // Assignment2 - Task15&16
        let content: CardContent // this is a made up don't care (generics)
        let id: Int // Int type but also could be UUID
    }
}
