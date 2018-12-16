//
//  UITestSampleUITests.swift
//  UITestSampleUITests
//
//  Created by Yasuyuki Someya on 2018/12/15.
//  Copyright © 2018年 Yasuyuki Someya. All rights reserved.
//

import XCTest

class ViewControllerUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
    }

    func testExample() {
        XCTContext.runActivity(named: "初期表示でTextViewの文言を確認") { (activity) in
            waitToAppear(for: app.textViews["ViewController_textView"])
            XCTAssertEqual(app.textViews["ViewController_textView"].value as? String,
                           "Hello world!\n\nXCUITestのサンプルです。")
        }
        XCTContext.runActivity(named: "ボタンをtap、ActionSheetのAction1をtapし、Labelの文言を確認") { (activity) in
            waitToHittable(for: app.buttons["ViewController_button"]).tap()
            waitToAppear(for: app.sheets["タイトル"])
            app.buttons["Action1"].tap()
            XCTAssertEqual(app.staticTexts["ViewController_label"].label,
                           "Action1がtapされました")
        }
        XCTContext.runActivity(named: "ボタンをtap、ActionSheetのAction2をtapし、Labelの文言を確認") { (activity) in
            waitToHittable(for: app.buttons["ViewController_button"]).tap()
            waitToAppear(for: app.sheets["タイトル"])
            app.buttons["Action2"].tap()
            XCTAssertEqual(app.staticTexts["ViewController_label"].label,
                           "Action2がtapされました")
        }
        XCTContext.runActivity(named: "ボタンをtap、ActionSheetのCancelをtapし、Labelの文言を確認") { (activity) in
            waitToHittable(for: app.buttons["ViewController_button"]).tap()
            waitToAppear(for: app.sheets["タイトル"])
            app.buttons["Cancel"].tap()
            XCTAssertFalse(app.staticTexts["ViewController_label"].exists)
        }
    }
}

extension XCTestCase {
    func waitToAppear(for element: XCUIElement,
                      timeout: TimeInterval = 5,
                      file: StaticString = #file,
                      line: UInt = #line) {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(result, .completed, file: file, line: line)
    }

    func waitToHittable(for element: XCUIElement,
                        timeout: TimeInterval = 5,
                        file: StaticString = #file,
                        line: UInt = #line) -> XCUIElement {
        let predicate = NSPredicate(format: "hittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(result, .completed, file: file, line: line)
        return element
    }
}
