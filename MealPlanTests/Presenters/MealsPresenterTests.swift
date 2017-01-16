// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MealsPresenterTests: XCTestCase {
    var subject: MealsPresenter!
    let view = MockMealsView()
    let model = MealsModel(userDefaults: MockUserDefaults())

    override func setUp() {
        super.setUp()

        subject = MealsPresenter(view: view, model: model)
    }

    func testUpdateMealsForView() {
        model.add(meal: Meal(title: "foo_meal"))
        model.add(meal: Meal(title: "bar_meal"))

        subject.updateMeals()

        XCTAssertTrue(view.setCalled, "meals were not set")
        XCTAssertEqual(model.getMeals(), view.setArguments, "incorrect meals were set")
        XCTAssertTrue(view.reloadCalled, "view was not reloaded")
    }

    func testAddMealForModel() {
        let fooMeal = Meal(title: "foo_meal")
        model.add(meal: fooMeal)

        XCTAssertEqual([fooMeal], model.getMeals(), "meal not added to model")
    }

    func testAddMealForView() {
        model.add(meal: Meal(title: "foo_meal"))

        let barMeal = Meal(title: "bar_meal")
        subject.add(meal: barMeal)

        XCTAssertTrue(view.setCalled, "view meals were not set")
        XCTAssertEqual(model.getMeals(), view.setArguments, "incorrect meals were set")
        XCTAssertTrue(view.reloadCalled, "view was not reloaded")
    }

    func testRemoveMealForModel() {
        let fooMeal = Meal(title: "foo_meal")
        model.add(meal: fooMeal)

        subject.remove(meal: fooMeal)

        XCTAssertEqual([], model.getMeals(), "meal not removed from model")
    }

    func testRemoveMealForView() {
        model.add(meal: Meal(title: "foo_meal"))

        let barMeal = Meal(title: "bar_meal")
        subject.remove(meal: barMeal)

        XCTAssertTrue(view.setCalled, "view meals were not set")
        XCTAssertEqual(model.getMeals(), view.setArguments, "incorrect meals were set")
    }
}

// MARK: Test doubles
class MockMealsView: MealsViewType {
    private(set) fileprivate var setCalled: Bool = false
    private(set) fileprivate var setArguments = [Meal]()
    private(set) fileprivate var reloadCalled: Bool = false

    func set(meals: [Meal]) {
        setCalled = true
        setArguments = meals
    }

    func reload() {
        reloadCalled = true
    }
}
