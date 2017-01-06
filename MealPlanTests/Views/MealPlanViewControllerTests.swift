// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealPlanViewPresenter: MealPlanViewPresenter {
    let view: MealPlanView

    required init(view: MealPlanView, model: MealsModel = MealsModel()) {
        self.view = view
    }

    func showMeals() {
        view.set(meals: ["yummy", "food"])
    }
}

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!
    var presenter: MealPlanViewPresenter!

    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealPlanViewController", storyboard: "Main") as! MealPlanViewController
        presenter = MockMealPlanViewPresenter(view: viewController)
        viewController.presenter = presenter

        viewController.assertView()
    }

    func testCountOfMealsInList() {
        let count = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(count, ["yummy", "food"].count)
    }
}
