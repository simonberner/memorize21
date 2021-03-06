import SwiftUI

// ViewModel for EmojiThemeModel
class EmojiThemeViewModel: ObservableObject {

    // read-only Array of EmojiThemeModels
    private(set) var emojiThemeModels: [EmojiThemeModel] = [
        EmojiThemeModel(name: "Animals",
                        emojis: ["π", "π", "π", "π¦", "πͺ²", "π¬", "π¦", "π¦’", "πΏ", "π¦", "π", "π¦§"],
                        numberOfPairsOfCards: 5,
                        color: .green),
        EmojiThemeModel(name: "Smileys",
                        emojis: ["π", "βΊοΈ", "βΉοΈ", "π€¬", "π₯Ά", "π΄", "π₯±", "π’", "π₯³", "π€©", "π₯°", "π·"],
                        color: .blue),
        EmojiThemeModel(name: "Objects",
                        emojis: ["π―", "πͺ", "π", "ππΎ", "βοΈ", "πͺ", "π±", "π", "π§²", "π°", "π§―", "π‘"],
                        numberOfPairsOfCards: 12,
                        color: .pink),
        EmojiThemeModel(name: "Flags",
                        emojis: ["π―π΅", "π¦π΄", "π΄σ §σ ’σ ·σ ¬σ ³σ Ώ", "πͺπ·", "π²πΆ", "πͺπΈ", "πΏπ¦", "πͺπΊ", "π§π·", "πΉπΏ", "π©π°", "π¨π¦"],
                        numberOfPairsOfCards: 12,
                        color: .yellow),
        EmojiThemeModel(name: "Sport",
                        emojis: ["ππΎββοΈ", "πͺ", "π€ΈπΏββοΈ", "π§π½ββοΈ", "π§π½ββοΈ", "π€Ί", "π€Ύπ½ββοΈ", "ππ½ββοΈ", "π€½π½ββοΈ", "π΄π½ββοΈ", "π£π½", "ππΎ"],
                        numberOfPairsOfCards: 6,
                        color: .purple),
        EmojiThemeModel(name: "Vehicles",
                        emojis: ["βοΈ", "π", "π", "π", "π΅", "π", "π", "β΅οΈ", "π ", "π¦½", "πΆ", "π"],
                        numberOfPairsOfCards: 12,
                        color: .red),
        EmojiThemeModel(name: "Halloween",
                        emojis: ["π»", "π", "π", "πͺ", "β", "πͺ", "π§¨", "π―", "β οΈ", "π£", "πͺ", "π«"],
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
        case "Animals" :
            return 0
        case "Smileys" :
            return 1
        case "Objects" :
            return 2
        case "Flags" :
            return 3
        case "Sport" :
            return 4
        case "Vehicles" :
            return 5
        case "Halloween" :
            return 6
        default :
            return 0
        }
    }

}
