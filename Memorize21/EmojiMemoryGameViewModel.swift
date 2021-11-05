import SwiftUI

// This is a ViewModel of MVVM
// It is always a class because we want to share an instance of it with different views at the same time!
// The ViewModel is the gatekeeper and its job is to protect the Model against odd behaving views
// (remember: classes are mutable, this is a pro and con because anyone who has a pointer to the same
// instance or var of a class, can change it!)
class EmojiMemoryGameViewModel: ObservableObject {
    typealias Card = MemoryGameModel<String>.Card
    private var emojiThemeViewModel = EmojiThemeViewModel()

    init() {
        emojiThemeModel = emojiThemeViewModel.emojiThemeModels.randomElement()! // Assignment2 - Task11
        emojiThemeModel.emojis.shuffle() // Assignment2 - Task5
        model = EmojiMemoryGameViewModel.createMemoryGame(emojiThemeModel: emojiThemeModel)
    }

    // this is a type function because it is static and belongs to the class (global scope) and not an instance of it
    private static func createMemoryGame(emojiThemeModel: EmojiThemeModel) -> MemoryGameModel<String> {
        // init the MemoryGameModel with numberOfPairsOfCards and a closure with the argument 'pairIndex'
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
    var cards: [Card] {
        return model.cards
    }

    var score: Int {
        return model.score
    }

    var emojiThemeColor: Color {
        return emojiThemeModel.color
    }

    var emojiThemeColorGradient: Gradient {
        switch emojiThemeModel.color {
        case .green:
            return Gradient(colors: [.green, .white])
        case .blue:
            return Gradient(colors: [.blue, .white])
        case .pink:
            return Gradient(colors: [.pink, .white])
        case .yellow:
            return Gradient(colors: [.yellow, .white])
        case .purple:
            return Gradient(colors: [.purple, .white])
        case .red:
            return Gradient(colors: [.red, .white])
        case .orange:
            return Gradient(colors: [.orange, .white])
        default:
            return Gradient(colors: [.black, .white])
        }
    }

    var emojiThemeName: String {
        emojiThemeModel.name
    }

    // MARK: - User intents

    func choose(_ card: Card) {
        model.choose(card)
    }

    func startNewGame(_ theme: EmojiThemeModel?) {
        emojiThemeModel = emojiThemeViewModel.getEmojiThemeModel(theme)
        model = EmojiMemoryGameViewModel.createMemoryGame(emojiThemeModel: emojiThemeModel)
    }

}
