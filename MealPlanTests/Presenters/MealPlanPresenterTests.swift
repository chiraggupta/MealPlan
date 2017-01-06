// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealPlanView: MealPlanView {
    private(set) fileprivate var setCalled = false
    private(set) fileprivate var setArguments = [Meal]()

    func set(meals: [Meal]) {
        setCalled = true
        setArguments = meals
    }
}

class MealPlanPresenterTests: XCTestCase {
    private var presenter: MealPlanPresenter!
    private let mealPlanView = MockMealPlanView()
    private let model = MealsModel()

    override func setUp() {
        presenter = MealPlanPresenter(view: mealPlanView, model: model)
    }

    func testShowMealsCallsViewSetWithCorrectArguments() {
        presenter.showMeals()
        XCTAssertTrue(mealPlanView.setCalled, "set was not called")
        XCTAssertEqual(model.getMeals(), mealPlanView.setArguments, "set was called with non matching meals")
    }
}
