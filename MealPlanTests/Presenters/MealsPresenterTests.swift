// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MealsPresenterTests: XCTestCase {
    var subject: MealsPresenter!
    let view = MockMealsView()
    let model = MealsModel(userDefaults: MockUserDefaults())

    override func setUp() {
        super.setUp()

        subject = MealsPresenter(view: view, mealsProvider: model)
    }

    func testUpdateMealsForView() {
        model.add(meal: Meal(title: "foo_meal"))
        model.add(meal: Meal(title: "bar_meal"))

        subject.updateMeals()

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

        XCTAssertEqual(model.getMeals(), view.setArguments, "incorrect meals were set")
    }

    func testTappingDoneHidesView() {
        subject.doneTapped()

        XCTAssertTrue(view.hideModalCalled)
    }
}

// MARK: Test doubles
extension MealsPresenterTests {
    class MockMealsView: MealsViewType {
        private(set) var setArguments = [Meal]()
        private(set) var reloadCalled = false
        private(set) var hideModalCalled = false

        func set(meals: [Meal]) {
            setArguments = meals
        }

        func reload() {
            reloadCalled = true
        }

        func hideModal() {
            hideModalCalled = true
        }

        func display(_ viewController: UIViewController) {}
        func displayModally(_ viewController: UIViewController) {}
    }
}
