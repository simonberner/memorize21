import Foundation
import SwiftUI

struct EmojiThemeModel: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var emojis: [String]
    var numberOfPairsOfCards: Int
    var color: Color

    init(name: String, emojis: [String], numberOfPairsOfCards: Int, color: Color) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCards = numberOfPairsOfCards > emojis.count ? emojis.count : numberOfPairsOfCards // Assignment2 - Task7
        self.color = color
    }

    // Assignment2 - ExtraCredit2
    // Random number of cards
    init(name: String, emojis: [String], randomNumberOfPairsOfCards: Bool, color: Color) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCards = randomNumberOfPairsOfCards ? Int.random(in: 2...emojis.count) : emojis.count // ternary operator
        self.color = color
    }

    // Assignment2 - ExtraCredit1
    init(name: String, emojis: [String], color: Color) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCards = emojis.count
        self.color = color
    }
}
