//
//  AppLauncher.swift
//  Memorize21
//
//  Created by Simon Berner on 15.02.23.
//

import SwiftUI

@main
/// Launches the App with a simple Text view when starting Unit-Tests.
/// With running the startup logic of the App, we are able to run our Unit-Tests faster
/// (see: https://blog.eidinger.info/faster-unit-tests-by-not-running-the-app-startup-logic?utm_source=swiftlee&utm_medium=swiftlee_weekly&utm_campaign=issue_117)
struct AppLauncher {

    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            Memorize21App.main()
        } else {
            print("starting TestApp for Unit-Tests...")
            TestApp.main()
        }
    }
}

struct TestApp: App {

    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}
