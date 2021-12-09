import Foundation
import SwiftUI

// class to share a reference to the static var dealt
class DealtCards: ObservableObject {

    // it has to be possible to set it from outside
    private var dealt: Set<Int>

    init(dealt: Set<Int>) {
        self.dealt = dealt
    }

    public func deal(_ card: EmojiMemoryGameViewModel.Card) {
        dealt.insert(card.id)
    }

    public func isUndealt(_ card: EmojiMemoryGameViewModel.Card) -> Bool {
        !dealt.contains(card.id) // a card is undealt if it is NOT already in the Set
    }

    public func resetDealt() {
        dealt = []
    }
}
