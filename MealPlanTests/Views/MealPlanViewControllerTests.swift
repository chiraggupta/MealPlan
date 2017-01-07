// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealPlanPresenter: MealPlanPresenterType {
    fileprivate var view: MealPlanView
    fileprivate var model: WeeklyMealPlanProvider

    init(view: MealPlanView, model: WeeklyMealPlanProvider) {
        self.view = view
        self.model = model
    }

    func showMeals() {
        view.set(mealPlan: model.getWeeklyMealPlan())
    }
}

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!
    var presenter: MockMealPlanPresenter!
    var expectedMealPlan: WeeklyMealPlan!

    override func setUp() {
        super.setUp()

        let model = MealPlanProviderWithTwoFakeMeals()
        expectedMealPlan = model.getWeeklyMealPlan()

        viewController = createVC(identifier: "MealPlanViewController", storyboard: "Main") as! MealPlanViewController
        presenter = MockMealPlanPresenter(view: viewController, model: model)
        viewController.presenter = presenter
        viewController.assertView()
    }

    func testCountOfMealsInList() {
        let expectedCount = expectedMealPlan.count
        let actualCount = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(expectedCount, actualCount, "meal list count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<expectedMealPlan.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            let day = DayOfWeek.byIndex(indexPath.row)
            XCTAssertEqual(day.rawValue, cell.textLabel?.text, "day \(i) is incorrect")

            let meal = expectedMealPlan[day]
            XCTAssertEqual(meal?.title, cell.detailTextLabel?.text, "meal \(i) title is incorrect")
        }
    }
}
