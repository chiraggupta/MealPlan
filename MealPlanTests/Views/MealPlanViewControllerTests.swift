// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealPlanViewPresenter: MealPlanViewPresenter {
    let view: MealPlanView
    var stubMealPlan = WeeklyMealPlan()

    required init(view: MealPlanView, model: WeeklyMealPlanProvider) {
        self.view = view
    }

    func showMeals() {
        view.set(mealPlan: stubMealPlan)
    }
}

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!
    var presenter: MealPlanViewPresenter!
    let stubMealPlan: WeeklyMealPlan = [
        DayOfWeek.monday: Meal(title: "foo"),
        DayOfWeek.tuesday: Meal(title: "bar")
    ]

    // MARK: Setup
    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealPlanViewController", storyboard: "Main") as! MealPlanViewController
        viewController.presenter = mockPresenter()

        viewController.assertView()
    }

    func mockPresenter() -> MealPlanViewPresenter {
        let mealPlanModel = WeeklyMealPlanModel(mealsModel: MealsProviderWithTwoFakeMeals())
        let mockPresenter = MockMealPlanViewPresenter(view: viewController, model: mealPlanModel)
        mockPresenter.stubMealPlan = stubMealPlan
        return mockPresenter
    }

    // MARK: Tests
    func testCountOfMealsInList() {
        let count = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(stubMealPlan.count, count, "meal list count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<stubMealPlan.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            let day = DayOfWeek.byIndex(indexPath.row)
            let meal = stubMealPlan[day]
            XCTAssertEqual(day.rawValue, cell.textLabel?.text, "day \(i) is incorrect")
            XCTAssertEqual(meal?.title, cell.detailTextLabel?.text, "meal \(i) title is incorrect")
        }
    }
}
