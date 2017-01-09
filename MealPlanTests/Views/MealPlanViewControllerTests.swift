// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealPlanPresenter: MealPlanPresenterType {
    fileprivate var updateMealPlanCalled = false
    func updateMealPlan() {
        updateMealPlanCalled = true
    }
}

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!
    let mockPresenter = MockMealPlanPresenter()

    let defaultData = [
        MealPlanViewData(day: "Monday", title: "meal 1"),
        MealPlanViewData(day: "Tuesday", title: ""),
        MealPlanViewData(day: "Wednesday", title: "meal 2"),
        MealPlanViewData(day: "Thursday", title: ""),
        MealPlanViewData(day: "Friday", title: ""),
        MealPlanViewData(day: "Saturday", title: "meal 3"),
        MealPlanViewData(day: "Sunday", title: "")
    ]

    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealPlanViewController", storyboard: "Main") as! MealPlanViewController
        viewController.presenter = mockPresenter

        viewController.set(mealPlanViewData: defaultData)
        viewController.assertView()
    }

    func testViewDidLoadCallsPresenterUpdateMealPlan() {
        XCTAssertTrue(mockPresenter.updateMealPlanCalled)
    }

    func testCountOfMealsInList() {
        let count = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(defaultData.count, count, "meal list count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<defaultData.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(defaultData[i].day, cell.textLabel?.text, "day \(i) is incorrect")
            XCTAssertEqual(defaultData[i].title, cell.detailTextLabel?.text, "meal \(i) title is incorrect")
        }
    }
}
