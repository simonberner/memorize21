import SwiftUI

// ViewModel for EmojiThemeModel
class EmojiThemeViewModel: ObservableObject {

    // read-only Array of EmojiThemeModels
    private(set) var emojiThemeModels: [EmojiThemeModel] = [
        EmojiThemeModel(name: "Animals",
                        emojis: ["🐍", "🐈", "🐇", "🦖", "🪲", "🐬", "🦒", "🦢", "🐿", "🦔", "🐘", "🦧"],
                        randomNumberOfPairsOfCards: true,
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
                        randomNumberOfPairsOfCards: true,
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

    func getEmojiThemeModel(_ theme: EmojiThemeModel?) -> EmojiThemeModel {
        var emojiThemeModel: EmojiThemeModel

        if theme == nil {
            emojiThemeModel = emojiThemeModels.randomElement()!
        } else {
            emojiThemeModel = theme!
        }
        emojiThemeModel.emojis.shuffle()

        return emojiThemeModel
    }

}
