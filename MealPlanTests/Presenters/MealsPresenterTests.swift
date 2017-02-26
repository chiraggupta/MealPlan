// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MealsPresenterTests: XCTestCase {
    var subject: MealsPresenter!
    let view = MockMealsView()
    var model: MealsModel!

    override func setUp() {
        super.setUp()

        let contextProvider = makeInMemoryPersistenContainer()
        model = MealsModel(contextProvider: contextProvider)
        subject = MealsPresenter(view: view, mealsProvider: model, contextProvider: contextProvider)
    }

    func testUpdateMealsForView() {
        _ = model.add(meal: Meal(name: "foo_meal"))
        _ = model.add(meal: Meal(name: "bar_meal"))

        subject.updateMeals()

        XCTAssertEqual(model.getMeals(), view.setArguments, "incorrect meals were set")
        XCTAssertTrue(view.reloadCalled, "view was not reloaded")
    }

    func testAddMealForModel() {
        let fooMeal = Meal(name: "foo_meal")
        _ = model.add(meal: fooMeal)

        XCTAssertEqual([fooMeal], model.getMeals(), "meal not added to model")
    }

    func testRemoveMealForModel() {
        _ = model.add(meal: Meal(name: "foo_meal"))

        subject.remove(mealName: "foo_meal")

        XCTAssertEqual([], model.getMeals(), "meal not removed from model")
    }

    func testRemoveMealForView() {
        _ = model.add(meal: Meal(name: "foo_meal"))
        _ = model.add(meal: Meal(name: "bar_meal"))

        subject.remove(mealName: "bar_meal")

        XCTAssertEqual(model.getMeals(), view.setArguments, "incorrect meals were set")
    }

    func testTappingDoneHidesView() {
        subject.closeTapped()

        XCTAssertTrue(view.hideModalCalled)
    }

    func testTappingAddPresentsAddMealsViewController() {
        subject.addTapped()

        XCTAssertTrue(view.displayedModally is UINavigationController)

        let displayedViewController = (view.displayedModally as? UINavigationController)?.topViewController
        XCTAssertTrue(displayedViewController is AddMealViewController)

        let presenter = (displayedViewController as? AddMealViewController)?.presenter
        XCTAssertTrue(presenter is AddMealPresenter)
    }
}

// MARK: Test doubles
extension MealsPresenterTests {
    class MockMealsView: MealsViewType {
        private(set) var setArguments = [Meal]()
        private(set) var reloadCalled = false
        private(set) var hideModalCalled = false
        private(set) var displayed: UIViewController?
        private(set) var displayedModally: UIViewController?

        func set(meals: [Meal]) {
            setArguments = meals
        }

        func reload() {
            reloadCalled = true
        }

        func hideModal() {
            hideModalCalled = true
        }

        func display(_ viewController: UIViewController) {
            displayed = viewController
        }

        func displayModally(_ viewController: UIViewController) {
            displayedModally = viewController
        }
    }
}
