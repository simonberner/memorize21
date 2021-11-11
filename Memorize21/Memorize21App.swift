//
//  Memorize21App.swift
//  Memorize21
//
//  Created by Simon Berner on 07.08.21.
//

import SwiftUI

@main
struct Memorize21App: App {
//    private let gameViewModel = EmojiMemoryGameViewModel()
    @State private var isShowing = true

    var body: some Scene {
        WindowGroup {
            ThemeChooserView(isShowing: $isShowing)
                .onAppear(perform: {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                })
            //            EmojiMemoryGameView(gameViewModel: gameViewModel)
            //                .onAppear(perform: {
            //                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            //                })
        }
    }
}
