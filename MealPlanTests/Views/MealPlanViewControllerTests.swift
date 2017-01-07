// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealPlanViewPresenter: MealPlanViewPresenter {
    let view: MealPlanView
    var mealPlan: WeeklyMealPlan

    required init(view: MealPlanView, model: WeeklyMealPlanProvider = MealPlanProviderWithTwoFakeMeals()) {
        self.view = view
        self.mealPlan = model.getWeeklyMealPlan()
    }

    func showMeals() {
        view.set(mealPlan: mealPlan)
    }
}

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!
    var presenter: MockMealPlanViewPresenter!

    // MARK: Setup
    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealPlanViewController", storyboard: "Main") as! MealPlanViewController
        presenter = MockMealPlanViewPresenter(view: viewController)
        viewController.presenter = presenter

        viewController.assertView()
    }

    // MARK: Tests
    func testCountOfMealsInList() {
        let expectedCount = presenter.mealPlan.count
        let actualCount = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(expectedCount, actualCount, "meal list count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<presenter.mealPlan.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            let day = DayOfWeek.byIndex(indexPath.row)
            XCTAssertEqual(day.rawValue, cell.textLabel?.text, "day \(i) is incorrect")

            let meal = presenter.mealPlan[day]
            XCTAssertEqual(meal?.title, cell.detailTextLabel?.text, "meal \(i) title is incorrect")
        }
    }
}
