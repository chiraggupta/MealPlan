// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MealsViewControllerTests: XCTestCase {
    var subject: MealsViewController = MealsFactory(contextProvider: FakeContextProvider()).instantiate()
    var presenter: MockMealsPresenter!
    let initialMeals = [Meal(name: "foo_meal")]

    override func setUp() {
        super.setUp()

        presenter = MockMealsPresenter(view: subject, initialMeals: initialMeals)
        subject.presenter = presenter

        subject.setAsRootViewController()
    }

    func testViewDidLoadCallsPresenterUpdateMeals() {
        XCTAssertTrue(presenter.updateMealsCalled)
    }

    func testCountOfMealsInList() {
        let count = subject.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(initialMeals.count, count, "meals count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<initialMeals.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = subject.tableView(subject.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(initialMeals[i].name, cell.textLabel?.text, "meal \(i + 1) is incorrect")
        }
    }

    func testTappingAddCallsPresenter() {
        subject.add(UIBarButtonItem())

        XCTAssertTrue(presenter.addTappedCalled)
    }

    func testRemoveMeal() {
        let firstRow = IndexPath(row: 0, section: 0)
        subject.tableView(subject.tableView, commit: .delete, forRowAt: firstRow)

        XCTAssertTrue(presenter.removeMealCalled)

        let newCount = subject.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(initialMeals.count - 1, newCount, "count should be one lesser")
    }

    func testTappingDoneCallsPresenter() {
        subject.done(UIBarButtonItem())

        XCTAssertTrue(presenter.cancelTappedCalled)
    }
}

// MARK: Test doubles
extension MealsViewControllerTests {
    class MockMealsPresenter: MealsPresenting {
        let view: MealsViewType!

        private(set) var updateMealsCalled = false
        private(set) var addMealCalled = false
        private(set) var addMealArgument: Meal?
        private(set) var removeMealCalled = false
        private(set) var addTappedCalled = false
        private(set) var cancelTappedCalled = false
        private(set) var meals: [Meal]!

        init(view: MealsViewType, initialMeals: [Meal]) {
            self.view = view
            meals = initialMeals
        }

        func updateMeals() {
            updateMealsCalled = true
            view.set(meals: meals)
            view.reload()
        }

        func add(meal: Meal) {
            addMealCalled = true
            addMealArgument = meal
            meals.append(meal)
            updateMeals()
        }

        func remove(mealName: String) {
            removeMealCalled = true

            if let indexToRemove = meals.index(where: {$0.name == mealName}) {
                meals.remove(at: indexToRemove)
            }

            view.set(meals: meals)
        }

        func addTapped() {
            addTappedCalled = true
        }

        func cancelTapped() {
            cancelTappedCalled = true
        }
    }
}
