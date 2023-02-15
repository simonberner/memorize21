//
//  Memorize21UITests.swift
//  Memorize21UITests
//
//  Created by Simon Berner on 07.08.21.
//

import XCTest

class Memorize21UITests: XCTestCase {

    let waitingTime = TimeInterval(integerLiteral: 1)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation -
        // required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Check that the 'New Game' Button is on the game view
    func testNewGameButtonAppears() throws {
        // Given
        let app = launchApp()

        // When
        app.collectionViews.buttons["selection.theme.Halloween"].tap()

        // Then
        XCTAssertTrue(app.buttons["newgame.button"].waitForExistence(timeout: waitingTime))
    }

    /// Check that the 'Info View' shows up on the screen
    func testInfoViewAppears() throws {
        // Given
        let app = launchApp()

        // When
        app.collectionViews.buttons["selection.theme.Objects"].tap()
        app.buttons["info.button"].tap()

        // Then
        XCTAssertTrue(app.staticTexts["made.smile"].waitForExistence(timeout: waitingTime))

    }

    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()

        return app
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}

// Some references:
// https://www.hackingwithswift.com/articles/148/xcode-ui-testing-cheat-sheet
// https://www.headspin.io/blog/xctest-a-complete-guide
// https://www.hackingwithswift.com/interview-questions/how-familiar-are-you-with-xctest-have-you-ever-created-ui-tests
// https://tanaschita.com/20220530-getting-started-with-ui-testing-for-swiftui-with-xctest-framework/
