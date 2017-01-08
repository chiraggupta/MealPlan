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

class MockMealsModel: MealsProvider {
    private(set) fileprivate var getMealsCalled: Bool = false
    private(set) fileprivate var addCalled: Bool = false
    private(set) fileprivate var addArgument: Meal?

    func getMeals() -> [Meal] {
        getMealsCalled = true
        return [Meal(title: "")]
    }
    func add(meal: Meal) {
        addCalled = true
        addArgument = meal
    }
}

class MealsPresenterTests: XCTestCase {
    private var presenter: MealsPresenter!
    private let view = MockMealsView()
    private let model = MockMealsModel()

    override func setUp() {
        super.setUp()

        presenter = MealsPresenter(view: view, model: model)
    }

    func testUpdateMealsSetsMealsToView() {
        presenter.updateMeals()

        XCTAssertTrue(view.setCalled, "set not called")
        XCTAssertEqual(model.getMeals(), view.setArguments, "set called with incorrect arguments")
    }

    func testAddMeals() {
        let meal = Meal(title: "bar")
        presenter.add(meal: meal)

        XCTAssertTrue(model.addCalled, "add not called")
        XCTAssertEqual(meal, model.addArgument, "add called with incorrect meal")
    }
    
}
