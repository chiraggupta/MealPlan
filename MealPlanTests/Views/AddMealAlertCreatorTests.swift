// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class PartialMockAlertActionCreator: AlertActionCreator {
    var handlerStorage = [String: AlertActionHandler]()

    override func create(title: String, style: UIAlertActionStyle, handler: AlertActionHandler?) -> UIAlertAction {
        handlerStorage[title] = handler
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}

class AddMealAlertTests: XCTestCase {
    var alertCreator: AddMealAlertCreator!
    let actionCreator = PartialMockAlertActionCreator()

    override func setUp() {
        super.setUp()

        alertCreator = AddMealAlertCreator(actionCreator: actionCreator)
    }

    func testAlertCreatedWithCorrectConfiguration() {
        let alert = alertCreator.create { _ in }
        XCTAssertNotNil(alert.view, "alert was not created")

        XCTAssertEqual("Add Meal", alert.title, "alert title is incorrect")
        XCTAssertEqual("Something that you cook regularly", alert.message, "alert message is incorrect")
        XCTAssertNotNil(alert.textFields?.first, "alert should have a text field")

        XCTAssertEqual(2, alert.actions.count, "alert should have 2 actions")
        XCTAssertEqual("Add", alert.actions.first?.title, "first action should be Add")
        XCTAssertEqual("Cancel", alert.actions.last?.title, "second action should be Cancel")
        XCTAssertEqual(UIAlertActionStyle.default, alert.actions.first?.style, "first action should have default style")
        XCTAssertEqual(UIAlertActionStyle.cancel, alert.actions.last?.style, "second action should have cancel style")
    }

    func testAlertActionAddShouldInvokeCallback() {
        let callbackInvoked = expectation(description: "alert called callback with ")

        let alert = alertCreator.create { mealTitle in
            XCTAssertEqual("foo", mealTitle, "meal title should be foo")
            callbackInvoked.fulfill()
        }

        let mealTitleTextField = alert.textFields?.first
        mealTitleTextField?.text = "foo"

        let addAction = alert.actions.first!
        let successHandler = actionCreator.handlerStorage["Add"]!
        successHandler(addAction)

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("Callback was not invoked. Error: \(error)")
            }
        }
    }
}
