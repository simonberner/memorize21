import SwiftUI

// This is a ViewModel of MVVM
// It is always a class because we want to share an instance of it with different views at the same time!
// The ViewModel is the gatekeeper and its job is to protect the Model against odd behaving views
// (remember: classes are mutable, this is a pro and con because anyone who has a pointer to the same
// instance or var of a class, can change it!)
class EmojiMemoryGameViewModel: ObservableObject {
    
    init() {
        emojiThemeModel = EmojiMemoryGameViewModel.emojiThemeModels.randomElement()! // Assignment2 - Task11
        emojiThemeModel.emojis.shuffle() // Assignment2 - Task5
        model = EmojiMemoryGameViewModel.createMemoryGame(emojiThemeModel: emojiThemeModel)
    }
    
    private static var emojiThemeModels: Array<EmojiThemeModel> = [
        EmojiThemeModel(name: "Animals",
                   emojis: ["🐍", "🐈", "🐇", "🦖", "🪲", "🐬", "🦒", "🦢", "🐿", "🦔", "🐘", "🦧"],
                   numberOfPairsOfCards: 12,
                   color: "green"),
        EmojiThemeModel(name: "Smileys",
                   emojis: ["😀", "☺️", "☹️", "🤬", "🥶", "😴", "🥱", "😢", "🥳", "🤩", "🥰", "😷"],
                   numberOfPairsOfCards: 8,
                   color: "blue"),
        EmojiThemeModel(name: "Objects",
                   emojis: ["🕯", "🪚", "🎁", "🛀🏾", "✂️", "🪄", "🎱", "🔓", "🧲", "💰", "🧯", "📡"],
                   numberOfPairsOfCards: 12,
                   color: "black"),
        EmojiThemeModel(name: "Flags",
                   emojis: ["🇯🇵", "🇦🇴", "🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🇪🇷", "🇲🇶", "🇪🇸", "🇿🇦", "🇪🇺", "🇧🇷", "🇹🇿", "🇩🇰", "🇨🇦"],
                   numberOfPairsOfCards: 12,
                   color: "yellow"),
        EmojiThemeModel(name: "Sport",
                   emojis: ["🏄🏾‍♀️", "🪂", "🤸🏿‍♂️", "🧘🏽‍♂️", "🧗🏽‍♂️", "🤺", "🤾🏽‍♂️", "🏌🏽‍♀️", "🤽🏽‍♀️", "🚴🏽‍♀️", "🚣🏽", "🏇🏾"],
                   numberOfPairsOfCards: 12,
                   color: "orange"),
        EmojiThemeModel(name: "Vehicles",
                   emojis: ["✈️", "🚜", "🚂", "🏎", "🛵", "🚀", "🚁", "⛵️", "🚠", "🦽", "🛶", "🚔"],
                   numberOfPairsOfCards: 12,
                   color: "red"),
        EmojiThemeModel(name: "Halloween",
                   emojis: ["✈️", "🚜", "🚂", "🏎", "🛵", "🚀", "🚁", "⛵️", "🚠", "🦽", "🛶", "🚔"],
                   numberOfPairsOfCards: 10,
                   color: "red")
    ]
    
    // this is a type function because it is static and belongs to the class (global scope) and not an instance of it
    private static func createMemoryGame(emojiThemeModel: EmojiThemeModel) -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairsOfCards: emojiThemeModel.numberOfPairsOfCards) { pairIndex in
            return emojiThemeModel.emojis[pairIndex]
        }
    }
    
    // access control - private(set): other structs/classes can look at the model, but can't change it
    // Swift detects changes in structs, that is why the model is a struct
    @Published private var model: MemoryGameModel<String>
     
    private var emojiThemeModel: EmojiThemeModel
    
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
    
    func startNewGame() {
        emojiThemeModel = EmojiMemoryGameViewModel.emojiThemeModels.randomElement()! // Assignment2 - Task11
        emojiThemeModel.emojis.shuffle() // Assignment2 - Task11
        model = EmojiMemoryGameViewModel.createMemoryGame(emojiThemeModel: emojiThemeModel)
    }
        
}
