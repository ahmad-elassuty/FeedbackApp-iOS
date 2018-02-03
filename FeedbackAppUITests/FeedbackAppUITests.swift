//
//  FeedbackAppUITests.swift
//  FeedbackAppUITests
//
//  Created by Ahmed Elassuty on 2/2/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble

let colleaguesListId        = "colleaguesListView"
let colleagueProfileId      = "colleagueProfileView"
let colleaguesTableViewId   = "colleaguesTableView"
let recentSectionTitle      = "You gave them feedback recently"
let colleaguesListTitle     = "Colleagues"

class FeedbackAppUITests: QuickSpec {
    override func spec() {
        var app                     : XCUIApplication!
        var colleagueslistElement   : XCUIElement!
        var tableView               : XCUIElement!
        var colleaguesProfileElement: XCUIElement!

        beforeSuite {
            app = XCUIApplication()
            app.launch()
            colleagueslistElement       = app.otherElements[colleaguesListId]
            tableView                   = colleagueslistElement.tables[colleaguesTableViewId]
            colleaguesProfileElement    = app.otherElements[colleagueProfileId]
        }

        afterSuite {
            app.terminate()
        }

        describe("Application") {
            context("upon app launch") {
                it("should display colleagues list as the landing screen") {
                    expect(colleagueslistElement.exists).to(beTrue())
                }
            }
        }

        describe("Colleagues List View Components") {
            context("upon appear") {
                it("should have a table to list colleagues") {
                    expect(tableView.exists).to(beTrue())
                }

                it("should have cells to represent the data") {
                    let cells = tableView.cells.allElementsBoundByIndex

                    expect(cells.isEmpty).to(beFalse())
                }

                it("should have navigation title to colleagues") {
                    let title = app.navigationBars["Colleagues"]

                    expect(title.exists).to(beTrue())
                }

                it("should have resent button") {
                    let resetButton = app.buttons["Reset"]

                    expect(resetButton.exists).to(beTrue())
                }
            }
        }

        describe("Colleagues List View Interaction") {
            context("when give feedback button tapped") {
                it("should move cell to recently interacted with section") {
                    let firstCell           = tableView.cells.firstMatch
                    let giveFeedbackButton  = firstCell.buttons["giveFeedback"]

                    expect(app.staticTexts[recentSectionTitle].exists).to(beFalse())

                    giveFeedbackButton.tap()

                    expect(app.staticTexts[recentSectionTitle].exists).to(beTrue())
                }
            }

            context("when reset button tapped") {
                it("should remove recently interacted with section") {
                    let resetButton = app.buttons["Reset"]

                    resetButton.tap()

                    expect(app.staticTexts[recentSectionTitle].exists).to(beFalse())
                }
            }

            context("when cell selected") {
                afterEach {
                    app.terminate()
                    app.launch()
                }

                it("should navigate to profile view") {
                    let firstCell = tableView.cells.firstMatch

                    expect(colleaguesProfileElement.exists).to(beFalse())

                    firstCell.tap()

                    expect(colleaguesProfileElement.exists).to(beTrue())
                }
            }
        }

        describe("Navigation back to colleagues list") {
            var firstCell: XCUIElement!

            beforeEach {
                firstCell = tableView.cells.element(boundBy: 3)
                firstCell.tap()
            }

            context("when back button tapped") {
                it("should navigate back to colleagues list") {
                    expect(colleaguesProfileElement.exists).to(beTrue())

                    app.buttons[colleaguesListTitle].tap()

                    expect(colleaguesProfileElement.exists).to(beFalse())
                }
            }

            context("when swipe right gesture triggered") {
                it("should navigate back to colleagues list") {
                    expect(colleaguesProfileElement.exists).to(beTrue())

                    let vector = CGVector(dx: 0, dy: 0.5)
                    let startCoordinate = colleaguesProfileElement.coordinate(
                        withNormalizedOffset: vector
                    )
                    let dx = colleaguesProfileElement.frame.width
                    let swipeVector = CGVector(dx: dx, dy: 0)
                    let endCoordinate = startCoordinate.withOffset(swipeVector)
                    startCoordinate.press(forDuration: 0.05, thenDragTo: endCoordinate)

                    expect(colleagueslistElement.exists).to(beTrue())
                }
            }
        }
    }
}
