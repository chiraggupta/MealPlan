// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealsView: MealsViewType {
    private(set) fileprivate var setCalled: Bool = false
    private(set) fileprivate var setArguments = [Meal]()

    func set(meals: [Meal]) {
        setCalled = true
        setArguments = meals
    }
}

class MealsPresenterTests: XCTestCase {
    private var presenter: MealsPresenter!
    private let view = MockMealsView()
    private let model = MealsProviderStub(count: 10)

    override func setUp() {
        super.setUp()

        presenter = MealsPresenter(view: view, model: model)
    }

    func testUpdateMealsSetsMeals() {
        presenter.updateMeals()

        XCTAssertTrue(view.setCalled, "set not called")
        XCTAssertEqual(model.getMeals(), view.setArguments, "incorrect arguments")
    }
    
}
