// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan



class MockMealPlanViewPresenter: MealPlanViewPresenter {
    let view: MealPlanView
    var stubMeals = [String]()

    required init(view: MealPlanView, model: MealsModel = MealsModel()) {
        self.view = view
    }

    func showMeals() {
        view.set(meals: stubMeals)
    }
}

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!
    var presenter: MealPlanViewPresenter!
    let stubMeals = ["foo", "bar"]

    // MARK: Setup
    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealPlanViewController", storyboard: "Main") as! MealPlanViewController
        presenter = MockMealPlanViewPresenter(view: viewController)
        viewController.presenter = mockPresenter()

        viewController.assertView()
    }

    func mockPresenter() -> MealPlanViewPresenter {
        let mockPresenter = MockMealPlanViewPresenter(view: viewController)
        mockPresenter.stubMeals = stubMeals
        return mockPresenter
    }

    // MARK: Tests
    func testCountOfMealsInList() {
        let count = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(count, stubMeals.count, "meal list count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<stubMeals.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(stubMeals[i], cell.textLabel?.text, "meal \(i + 1) should be \(stubMeals[i])")
        }
    }
}
