import SwiftUI

struct InfoView: View {

    // @Binding property wrapper
    // tells the view to update itself whenever the value changes
    // it does not store its own value, the state is stored elsewhere
    @Binding var isShowing: Bool
    @State private var showTipJarView = false
    @State private var tipJarSheetDetent: PresentationDetent = .medium

    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                    .foregroundColor(Color.white)
                ScrollView(showsIndicators: true) {
                    VStack {
                        HStack {
                            Text("Infos")
                                .font(.headline)
                                .padding()
                        }
                        HStack {
                            Text("Memorize Game")
                            Spacer()
                            Text("Version " + UIApplication.appVersion!)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        HStack {
                            Text("Source code")
                            Spacer()
                            Text(Image(systemName: "link"))
                                .foregroundColor(.blue)
                            Link("GitHub Repo",
                                 destination: URL(string: "https://github.com/simonberner/memorize21")!)
                                .foregroundColor(Color.blue)
                        }
                        .padding()
                        Divider()
                        HStack {
                            Text("Game Scoring Rules")
                            Spacer()
                        }
                        .padding()
                        ScrollView {
                            Text(ViewConstants.gameRules)
                                .padding()
                        }
                        Divider()
                        Text("In 2021, I have started my learning journey in iOS Development. This App here is my first iOS App I have built. I hope you have fun and are enjoying the game. If you face any bugs in using it on your mobile phone, please let me know by writing an email to sibebzh@gmail.com")
                            .padding()
                        Text("Made with a 🙂")
                            .accessibilityIdentifier("made.smile")
                        Button("💲Tip Me") {
                            showTipJarView = true
                        }
                        .tint(.pink)
                        .buttonStyle(.bordered)
                        .padding(.top)
                    }
                    .overlay(alignment: .topTrailing) {
                        DismissButton()
                            .padding()
                    }
                }
            }
            .foregroundColor(ViewConstants.textColor)
            .sheet(isPresented: $showTipJarView) {
                TipJarView(showTips: $showTipJarView)
                    .environmentObject(TipsStore())
                    .presentationDetents([.medium, .large], selection: $tipJarSheetDetent)
            }
    }
}

private struct ViewConstants {
    static let foregroundOpacity = 0.6
    static let cornerRadius: CGFloat = 12
    static let textColor = Color.black
    static let gameRules = """
Rule 1: The faster you find two matching cards, the more scores you can accumulate.
Rule 2: If you turn up a card for the second time (and further) and you don't find a match, you loose points.
Rule 3: If you find a match before the animated pie time of 8 seconds per card has passed, you gain some extra scores.
"""
}

struct InfoView_Previews: PreviewProvider {

    static var previews: some View {
        InfoView(isShowing: .constant(true))
    }
}
