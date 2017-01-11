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

    func resetState() {
        setCalled = false
        setArguments = []
    }
}

class MockMealsModel: MealsProvider {
    private(set) fileprivate var getMealsCalled: Bool = false
    private(set) fileprivate var addCalled: Bool = false
    private(set) fileprivate var addArgument: Meal?
    private(set) fileprivate var removeCalled: Bool = false
    private(set) fileprivate var removeArgument: Meal?

    func getMeals() -> [Meal] {
        getMealsCalled = true

        var meals = [Meal(title: "foo_Meal")]
        if let addedMeal = addArgument {
            meals.append(addedMeal)
        }

        return meals
    }

    func add(meal: Meal) {
        addCalled = true
        addArgument = meal
    }

    func remove(meal: Meal) {
        removeCalled = true
        removeArgument = meal
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

        XCTAssertTrue(view.setCalled, "view set not called")
        XCTAssertTrue(model.getMealsCalled, "model getMeals not called")
        XCTAssertEqual(model.getMeals(), view.setArguments, "set called with incorrect arguments")
    }

    func testAddMealAddsMealToModel() {
        let meal = Meal(title: "bar_Meal")
        presenter.add(meal: meal)

        XCTAssertTrue(model.addCalled, "add not called")
        XCTAssertEqual(meal, model.addArgument, "add called with incorrect meal")
    }

    func testAddMealSetsUpdatedMealsToView() {
        let meal = Meal(title: "bar_Meal")
        presenter.add(meal: meal)

        XCTAssertTrue(model.getMealsCalled, "model getMeals not called")
        XCTAssertTrue(view.setCalled, "view set not called")
        XCTAssertEqual(model.getMeals(), view.setArguments, "view set called with incorrect arguments")
    }

    func testRemoveMealRemovesMealFromModel() {
        let meal = Meal(title: "foo_meal")
        presenter.remove(meal: meal)

        XCTAssertTrue(model.removeCalled, "remove not called")
        XCTAssertEqual(meal, model.removeArgument, "remove called with incorrect meal")
    }

    func testRemoveMealSetsUpdatedMealsToView() {
        let meal = Meal(title: "foo_Meal")
        presenter.add(meal: meal)
        view.resetState()

        presenter.remove(meal: meal)

        XCTAssertTrue(model.removeCalled, "model getMeals not called")
        XCTAssertTrue(view.setCalled, "view set not called")
        XCTAssertEqual(model.getMeals(), view.setArguments, "view set called with incorrect arguments")
    }
}
