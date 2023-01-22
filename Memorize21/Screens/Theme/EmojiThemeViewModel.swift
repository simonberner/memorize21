import SwiftUI

// ViewModel for EmojiThemeModel
class EmojiThemeViewModel: ObservableObject {

    // read-only Array of EmojiThemeModels
    private(set) var emojiThemeModels: [EmojiThemeModel] = [
        EmojiThemeModel(name: "Animals",
                        emojis: ["🐍", "🐈", "🐇", "🦖", "🪲", "🐬", "🦒", "🦢", "🐿", "🦔", "🐘", "🦧"],
                        numberOfPairsOfCards: 5,
                        color: .green),
        EmojiThemeModel(name: "Smileys",
                        emojis: ["😀", "☺️", "☹️", "🤬", "🥶", "😴", "🥱", "😢", "🥳", "🤩", "🥰", "😷"],
                        color: .blue),
        EmojiThemeModel(name: "Objects",
                        emojis: ["🕯", "🪚", "🎁", "🛀🏾", "✂️", "🪄", "🎱", "🔓", "🧲", "💰", "🧯", "📡"],
                        numberOfPairsOfCards: 12,
                        color: .pink),
        EmojiThemeModel(name: "Flags",
                        emojis: ["🇯🇵", "🇦🇴", "🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🇪🇷", "🇲🇶", "🇪🇸", "🇿🇦", "🇪🇺", "🇧🇷", "🇹🇿", "🇩🇰", "🇨🇦"],
                        numberOfPairsOfCards: 12,
                        color: .yellow),
        EmojiThemeModel(name: "Sport",
                        emojis: ["🏄🏾‍♀️", "🪂", "🤸🏿‍♂️", "🧘🏽‍♂️", "🧗🏽‍♂️", "🤺", "🤾🏽‍♂️", "🏌🏽‍♀️", "🤽🏽‍♀️", "🚴🏽‍♀️", "🚣🏽", "🏇🏾"],
                        numberOfPairsOfCards: 6,
                        color: .purple),
        EmojiThemeModel(name: "Vehicles",
                        emojis: ["✈️", "🚜", "🚂", "🏎", "🛵", "🚀", "🚁", "⛵️", "🚠", "🦽", "🛶", "🚔"],
                        numberOfPairsOfCards: 12,
                        color: .red),
        EmojiThemeModel(name: "Halloween",
                        emojis: ["👻", "💀", "🎃", "🔪", "⛓", "🪓", "🧨", "🕯", "☠️", "💣", "🪚", "🔫"],
                        numberOfPairsOfCards: 10,
                        color: .orange)
    ]

    func getEmojiThemeModel(_ themeName: String?) -> EmojiThemeModel {
        var emojiThemeModel: EmojiThemeModel

        if themeName == nil {
            emojiThemeModel = emojiThemeModels.randomElement()!
        } else {
            emojiThemeModel = emojiThemeModels[getEmojiThemeModelByName(themeName)]
        }
        emojiThemeModel.emojis.shuffle()

        return emojiThemeModel
    }

    private func getEmojiThemeModelByName(_ themeName: String?) -> Int {
        switch themeName {
        case "Animals":
            return 0
        case "Smileys":
            return 1
        case "Objects":
            return 2
        case "Flags":
            return 3
        case "Sport":
            return 4
        case "Vehicles":
            return 5
        case "Halloween":
            return 6
        default:
            return 0
        }
    }

    static var exampleEmojiThemeModel = (
        EmojiThemeModel(name: "Animals",
                        emojis: ["🐍", "🐈", "🐇", "🦖", "🪲", "🐬", "🦒", "🦢", "🐿", "🦔", "🐘", "🦧"],
                        numberOfPairsOfCards: 5,
                        color: .green)
    )

}
