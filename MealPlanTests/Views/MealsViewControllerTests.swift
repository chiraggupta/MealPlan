// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MockMealsPresenter: MealsPresenterType {
    fileprivate var updateMealsCalled = false
    func updateMeals() {
        updateMealsCalled = true
    }

    func add(meal: Meal) {}
}

class MealsViewControllerTests: XCTestCase {
    var viewController: MealsViewController!
    let mockPresenter = MockMealsPresenter()

    var defaultData = [
        Meal(title: "meal 1"),
        Meal(title: "meal 2"),
        Meal(title: "meal 3")
    ]

    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealsViewController", storyboard: "Main") as! MealsViewController
        viewController.presenter = mockPresenter

        viewController.set(meals: defaultData)
        viewController.assertView()
    }

    func testViewDidLoadCallsPresenterUpdateMeals() {
        XCTAssertTrue(mockPresenter.updateMealsCalled)
    }

    func testCountOfMealsInList() {
        let count = viewController.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(defaultData.count, count, "meals count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<defaultData.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(defaultData[i].title, cell.textLabel?.text, "meal \(i + 1) is incorrect")
        }
    }    
}
