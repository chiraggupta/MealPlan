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

    func testTappingAddShowsAddMealAlert() {
        viewController.add(UIBarButtonItem())

        guard let alert = viewController.presentedViewController as? UIAlertController else {
            XCTFail("alert not presented")
            return
        }

        XCTAssertEqual("Add Meal", alert.title, "alert title is incorrect")
    }
}
