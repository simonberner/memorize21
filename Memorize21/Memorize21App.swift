//
//  Memorize21App.swift
//  Memorize21
//
//  Created by Simon Berner on 07.08.21.
//

import SwiftUI

@main
struct Memorize21App: App {
    let gameViewModel = EmojiMemoryGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(gameViewModel: gameViewModel)
        }
    }
}
