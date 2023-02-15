import SwiftUI

struct ThemeChooserView: View {

    @Binding var isShowing: Bool
    @State private var selection: String?
    @State private var emojiThemeModels = EmojiThemeViewModel().emojiThemeModels

    let headerFont = Font.custom(FontNameManager.permanentMarker, size: 40)

    var body: some View {
        VStack {
            Text("Memorize21")
                .font(headerFont)
                .fontWeight(.heavy)
            NavigationStack {
                List(emojiThemeModels) { theme in
                    NavigationLink(value: theme) { // iOS 16.0+: Creates a navigation link that presents the view corresponding to a value.
                        Text(getThemeInfo(theme))
                            .foregroundColor(theme.color)
                    }
                    .accessibilityIdentifier("selection.theme.\(theme.name)")
                }
                .navigationDestination(for: EmojiThemeModel.self, destination: { theme in
                    EmojiMemoryGameView(gameViewModel: EmojiMemoryGameViewModel(selectedTheme: theme))
                })
                .navigationTitle("Select a Theme to play with:")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    func getThemeInfo(_ theme: EmojiThemeModel) -> String {
        let themeInfo = theme.emojis[0]
        + " - "
        + theme.name
        + " - "
        + String(theme.numberOfPairsOfCards)
        + " pairs of cards"
        return themeInfo
    }
}

struct ThemeChooser_Previews: PreviewProvider {

    static var previews: some View {
        ThemeChooserView(isShowing: .constant(true))
            .preferredColorScheme(.dark)
        ThemeChooserView(isShowing: .constant(true))
            .preferredColorScheme(.light)
    }
}
