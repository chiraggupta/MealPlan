// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MockMealsPresenter: MealsPresenterType {
    fileprivate var updateMealsCalled = false
    fileprivate var addMealCalled = false
    fileprivate var addMealArgument: Meal?

    func updateMeals() {
        updateMealsCalled = true
    }

    func add(meal: Meal) {
        addMealCalled = true
        addMealArgument = meal
    }
}

class MockAlertActionCreator: AlertActionCreator {
    var handlerStorage = [String: AlertActionHandler]()

    override func create(title: String, style: UIAlertActionStyle, handler: AlertActionHandler?) -> UIAlertAction {
        handlerStorage[title] = handler
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}

class MealsViewControllerTests: XCTestCase {
    var viewController: MealsViewController!
    let mockPresenter = MockMealsPresenter()
    let mockAlertActionCreator = MockAlertActionCreator()

    var defaultData = [
        Meal(title: "meal 1"),
        Meal(title: "meal 2"),
        Meal(title: "meal 3")
    ]

    override func setUp() {
        super.setUp()

        viewController = makeViewController(storyboard: "Main")
        viewController.presenter = mockPresenter

        viewController.display()
    }

    func testViewDidLoadCallsPresenterUpdateMeals() {
        XCTAssertTrue(mockPresenter.updateMealsCalled)
    }

    func testCountOfMealsInList() {
        viewController.set(meals: defaultData)

        let count = viewController.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(defaultData.count, count, "meals count is incorrect")
    }

    func testMealsDisplayedInList() {
        viewController.set(meals: defaultData)

        for i in 0..<defaultData.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(defaultData[i].title, cell.textLabel?.text, "meal \(i + 1) is incorrect")
        }
    }

    func testAddMealControllerShowsUpCorrectly() {
        viewController.add(UIBarButtonItem())

        guard let alert = viewController.presentedViewController as? UIAlertController else {
            XCTFail("alert not presented")
            return
        }

        XCTAssertEqual("Add Meal", alert.title, "alert title is incorrect")
        XCTAssertEqual("Something that you cook regularly", alert.message, "alert message is incorrect")
        XCTAssertNotNil(alert.textFields?.first, "alert should have a text field")

        XCTAssertEqual(2, alert.actions.count, "alert should have 2 actions")
        XCTAssertEqual("Add", alert.actions.first?.title, "first action should be Add")
        XCTAssertEqual("Cancel", alert.actions.last?.title, "second action should be Cancel")
        XCTAssertEqual(UIAlertActionStyle.default, alert.actions.first?.style, "first action should have default style")
        XCTAssertEqual(UIAlertActionStyle.cancel, alert.actions.last?.style, "second action should have cancel style")
    }

    func testAlertActionAdd() {
        viewController.alertActionCreator = mockAlertActionCreator
        viewController.add(UIBarButtonItem())

        guard let alert = viewController.presentedViewController as? UIAlertController else {
            XCTFail("alert not presented")
            return
        }

        alert.textFields?.first?.text = "foo"

        let addAction = alert.actions.first!
        let addHandler = mockAlertActionCreator.handlerStorage["Add"]!
        addHandler(addAction)

        XCTAssertTrue(mockPresenter.addMealCalled)
        XCTAssertEqual(Meal(title: "foo"), mockPresenter.addMealArgument)
        XCTAssertTrue(mockPresenter.updateMealsCalled)
    }
}
