//
//  Memorize21Tests.swift
//  Memorize21Tests
//
//  Created by Simon Berner on 07.08.21.
//

import XCTest
@testable import Memorize21

// Run Unit-Tests by not running the App: https://blog.eidinger.info/faster-unit-tests-by-not-running-the-app-startup-logic?utm_source=swiftlee&utm_medium=swiftlee_weekly&utm_campaign=issue_117
class Memorize21Tests: XCTestCase {

    // Put setup code here. This method is called before the invocation of each test method in the class.
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    // Put teardown code here. This method is called after the invocation of each test method in the class.
    override func tearDownWithError() throws {
    }

    // Check that a specific EmojiThemeModel has the correct numberOfPairsOfCards
    func testGetEmojiThemeModel() throws {
        // Arrange & Act
        let emojiThemeModel = EmojiThemeViewModel().getEmojiThemeModel("Animals")

        // Assert
        XCTAssertEqual(emojiThemeModel.numberOfPairsOfCards, 5)

    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
