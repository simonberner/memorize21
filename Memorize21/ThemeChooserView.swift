import SwiftUI

struct ThemeChooserView: View {

    @Binding var isShowing: Bool
    @State private var selection: String?
    @State private var emojiThemeModels = EmojiThemeViewModel().emojiThemeModels

    var body: some View {
        VStack {
            Text("Memorize21")
                .font(.title)
                .fontWeight(.heavy)
            NavigationView {
                List(emojiThemeModels) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(gameViewModel: EmojiMemoryGameViewModel(selectedTheme: selection)), tag: theme.name, selection: $selection) { Text(getThemeInfo(theme)) }
                    .foregroundColor(theme.color)
                }
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
    @State static var isShowing = true
    @State static var chosenTheme: String?

    static var previews: some View {
        ThemeChooserView(isShowing: $isShowing)
            .preferredColorScheme(.dark)
        ThemeChooserView(isShowing: $isShowing)
            .preferredColorScheme(.light)
    }
}

// Other attempts to solve the "which theme is selected" problem

//    List(emojiThemeModels, selection: $selection) { theme in
//        Text(getThemeInfo(theme))
//            .tag(theme.name) // Identifies the button in the List for selection
//            .listRowBackground(theme.color)
//    }
//    .padding()
//    .cornerRadius(12)
//    .navigationTitle("Selected Theme: \(selection ?? "none") ")
//    .navigationBarTitleDisplayMode(.inline)
//    .toolbar {
//        ToolbarItemGroup(placement: .navigationBarLeading, content: {
//            EditButton()
//            Spacer()
//        })
//        ToolbarItemGroup(placement: .navigationBarTrailing, content: {
//            closeButton
//        })
//    }
// }
// .cornerRadius(14)

// GeometryReader { geometry in
//    VStack(spacing: 12) {
//        Text("Selected Theme: ").fontWeight(.heavy) +
//        Text(selection ?? " none")
//            .foregroundColor(selection == nil ? .red : .primary)
//        List($emojiThemeModels, selection: $selection) { $theme in
//            Text(getThemeInfo(theme))
//                .listRowBackground(theme.color)
//        }
//        .frame(width: geometry.size.width, height: geometry.size.height)
//    }
// }

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

//            ZStack {
//                RoundedRectangle(cornerRadius: 12)
//                    .foregroundColor(Color.white)

//                VStack {
//                    HStack {
//                        Text("Themes")
//                            .font(.headline)
//                            .foregroundColor(.black)
//                        Button(action: {
//                            isShowing = false
//                        }, label: {
//                            Spacer()
//                            Image(systemName: "xmark")
//                                .foregroundColor(Color.red)
//                        })
//                            .accessibilityLabel("theme.button")
//                    }
//                    .padding()

//                        Button(action: {
//                            chosenTheme = theme
//                            imageName = (theme.name == selection) ? "star.circle.fill" : "circle"
//                            isShowing = false
//                            print("imageName is: \(imageName)")
//                            print("chosen theme is: \(theme.name)")
//                            print("theme id:\(theme.id)")
//                            // WHY is the var 'selection' always empty???
//                            print("theme selection: \(selection ?? "")")
//                        }, label: {
//                            HStack {
// //                                    Image(systemName: imageName)
// //                                        .foregroundColor(Color.white)
//                                Text(getThemeInfo(theme))
//                            }
//                        })
