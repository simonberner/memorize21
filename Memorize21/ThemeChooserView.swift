import SwiftUI

struct ThemeChooserView: View {

    @Binding var isShowing: Bool
    @Binding var chosenTheme: EmojiThemeModel?
    @State private var selection: String?
    @ObservedObject private var emojiThemeViewModel = EmojiThemeViewModel()
    @State private var imageName = "circle"

    var body: some View {
        if isShowing {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.white)

                VStack {
                    HStack {
                        Text("Select a theme:")
                            .font(.headline)
                            .foregroundColor(.black)
                        Button(action: {
                            isShowing = false
                        }, label: {
                            Spacer()
                            Image(systemName: "xmark")
                                .foregroundColor(Color.red)
                        })
                            .accessibilityLabel("theme.button")
                    }
                    .padding()
                    // An NavigationView looks just awful in landscape
//                    NavigationView {
                        List(emojiThemeViewModel.emojiThemeModels, selection: $selection) { theme in
                            Button(action: {
                                chosenTheme = theme
                                imageName = (theme.name == selection) ? "star.circle.fill" : "circle"
                                isShowing = false
                                print("imageName is: \(imageName)")
                                print("chosen theme is: \(theme.name)")
                                print("theme id:\(theme.id)")
                                // WHY is the var 'selection' always empty???
                                print("theme selection: \(selection ?? "")")
                            }, label: {
                                HStack {
                                    Image(systemName: imageName)
                                        .foregroundColor(Color.white)
                                    Text(getThemeInfo(theme))
                                }
                            })
                                .cornerRadius(12)
                                .tag(theme.name) // Identifies the button in the List for selection
                                .listRowBackground(theme.color)
                        }
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .padding()
//                    }
                }
            }
        }
    }

    func getThemeInfo(_ theme: EmojiThemeModel) -> String {
        let themeInfo = theme.name
        + " - "
        + theme.emojis[0]
        + " - "
        + String(theme.numberOfPairsOfCards)
        + " pairs of cards"
        return themeInfo
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    @State static var isShowing = true
    @State static var chosenTheme: EmojiThemeModel?

    static var previews: some View {
        ThemeChooserView(isShowing: $isShowing, chosenTheme: $chosenTheme)
            .preferredColorScheme(.dark)
        ThemeChooserView(isShowing: $isShowing, chosenTheme: $chosenTheme)
            .preferredColorScheme(.light)
    }
}

// Other attempts to solve the "which theme is selected" problem

// VStack {
//    HStack {
//        Text("Select a theme")
//            .font(.headline)
//        Button(action: {
//            isShowing = false
//        }, label: {
//            Spacer()
//            Image(systemName: "xmark")
//                .foregroundColor(Color.red)
//        })
//            .accessibilityLabel("theme.button")
//    }
//    .padding()
//
//    NavigationView {
//        List(emojiThemeViewModel.emojiThemeModels, selection: $selection) { theme in
//            Button(action: {
//                chosenTheme = theme
//                imageName = (theme.id == selection) ? "star.circle.fill" : "circle"
//                isShowing = false
//                print("ImageName is: \(imageName)")
//                print("Chosen Theme is: \(theme.name)")
//                print("theme id:\(theme.id)")
//            }, label: {
//                HStack {
//                    Image(systemName: imageName)
//                        .foregroundColor(Color.white)
//                    Text(getThemeInfo(theme))
//                }
//            })
//                .tag(theme.id)
//                .listRowBackground(theme.color)
//        }
//        .foregroundColor(.black)
//
//    }
//
// }

// ZStack {
//    RoundedRectangle(cornerRadius: 12)
//        .foregroundColor(Color.white)
//    VStack {
//        NavigationView {
//            List(emojiThemeViewModel.emojiThemeModels, selection: $selection) { theme in
//                Text(getThemeInfo(theme)).tag(theme.id)
//                    .listRowBackground(theme.color)
//            }
//            .navigationBarItems(trailing: EditButton())
//            .navigationBarTitle(
//                "Selected Theme: \(emojiThemeViewModel.emojiThemeModels.first { $0.id == selection}?.name ?? "random")",
//                               displayMode: .inline)
//        }
//        Button(action: {
//            isShowing = false
//            chosenTheme = emojiThemeViewModel.emojiThemeModels.first {$0.id == selection}
// //                        print("chosen theme is =\(chosenTheme?.name ?? "none")")
//        }, label: {
//            Spacer()
//            Text("Done")
//                .padding()
//        })
//    }
// }
