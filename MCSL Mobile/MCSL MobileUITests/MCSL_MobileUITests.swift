//
//  MCSL_MobileUITests.swift
//  MCSL MobileUITests
//
//  Created by Jerry Ji on 12/28/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import XCTest

class MCSL_MobileUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        sleep(25)
        saveScreenshot("0Home")
        let mcslMobileNavigationBar = app.navigationBars["MCSL Mobile"]
        mcslMobileNavigationBar.searchFields["Search Swimmer"].tap()
        sleep(5)
        app/*@START_MENU_TOKEN@*/.keys["J"]/*[[".keyboards.keys[\"J\"]",".keys[\"J\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.keys["h"].tap()
        app.keys["n"].tap()
        sleep(5)
        while app.staticTexts["John A Craig"].isVisible == false{
            sleep(15)
        }
        saveScreenshot("1Search")
        mcslMobileNavigationBar.buttons["Cancel"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["BETHESDA"]/*[[".cells.staticTexts[\"BETHESDA\"]",".staticTexts[\"BETHESDA\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(10)
        saveScreenshot("2Team")
        sleep(10)
        app.navigationBars["BETHESDA"].buttons["Teams"].tap()
                        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["INVERNESS RECREATION CLUB"]/*[[".cells.staticTexts[\"INVERNESS RECREATION CLUB\"]",".staticTexts[\"INVERNESS RECREATION CLUB\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.element.scrollToElement(tablesQuery.cells.containing(.staticText, identifier:"JiRui N Ji").element)
        let starButton = tablesQuery.cells.containing(.staticText, identifier:"JiRui N Ji").images["star"]
        if starButton.exists{
            starButton.tap()
        }
        sleep(10)
        saveScreenshot("3Team")
        tablesQuery.cells.containing(.staticText, identifier:"JiRui N Ji").element.tap()
        tablesQuery.buttons["Week 5"].tap()
        tablesQuery.buttons["Week 4"].tap()
        tablesQuery.buttons["Week 3"].tap()
        tablesQuery.buttons["Week 2"].tap()
        tablesQuery.buttons["Week 1"].tap()
        sleep(10)
        saveScreenshot("4Member")
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Favorites"].tap()
        sleep(10)
        saveScreenshot("5Favorites")
        tabBar.buttons["Home"].tap()
        tabBar.buttons["Settings"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.buttons["Alternative Icons"]/*[[".cells[\"Alternative Icons\"].buttons[\"Alternative Icons\"]",".buttons[\"Alternative Icons\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(10)
        saveScreenshot("6Icons")
        
    }
    
    func saveScreenshot(_ name: String) {
            let screenshot = XCUIScreen.main.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot)
            attachment.lifetime = .keepAlways
            attachment.name = name
            snapshot(name)
            add(attachment)
        }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement {
    func scrollToElement(_ element: XCUIElement) {
        while !element.isVisible {
            swipeUp()
        }
    }
    
    var isVisible: Bool {
        return exists && !frame.isEmpty &&
            XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }
}

