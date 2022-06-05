//
//  GIFUPUITests.swift
//  GIFUPUITests
//
//  Created by onur on 5.06.2022.
//

import XCTest

class GIFUPUITests: XCTestCase {

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
        app.launch()
 
        let GIFUPHomeviewNavigationBar = app.navigationBars["GIFUP.HomeView"]
        XCTAssertTrue(GIFUPHomeviewNavigationBar.exists)
        
        let searchController = GIFUPHomeviewNavigationBar.searchFields["Search"]
        XCTAssertTrue(searchController.exists)
        searchController.tap()
        searchController.typeText("Test")
        sleep(5)
        
        let collectionViewElement = app.collectionViews.children(matching: .cell).element(boundBy: 0)
        if collectionViewElement.exists {
            collectionViewElement.tap()
            app.navigationBars.buttons["Back"].tap()
        }
        sleep(2)
        GIFUPHomeviewNavigationBar.buttons["Cancel"].tap()
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
