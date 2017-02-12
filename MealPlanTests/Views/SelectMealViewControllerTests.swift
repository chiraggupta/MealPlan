// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class SelectMealViewControllerTests: XCTestCase {
    var subject: SelectMealViewController!
    var presenter = MockSelectMealPresenter()
    let meals = ["foo_meal", "bar_meal"]

    override func setUp() {
        super.setUp()

        let factory = SelectMealFactory(contextProvider: FakeContextProvider(), day: .monday)
        subject = factory.instantiate()
        subject.presenter = presenter
        subject.set(meals: meals)
        
        subject.setAsRootViewController()
    }

    func testViewDidLoadLoadsMeals() {
        XCTAssertTrue(presenter.loadMealsCalled)
    }

    func testSetTitle() {
        subject.set(title: "foobarbazqux")
        XCTAssertEqual("foobarbazqux", subject.title, "view title not set correctly")
    }

    func testCountOfMealsInList() {
        let count = subject.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(meals.count, count, "meals count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<meals.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = subject.tableView(subject.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(meals[i], cell.textLabel?.text, "meal \(i + 1) is incorrect")
            XCTAssertEqual(cell.accessoryType, .none, "cell shouldn't have a checkmark")
        }
    }

    func testSelectedMealsShowCheckmarks() {
        presenter.select(mealTitle: "foo_meal")
        let first = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let second = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(.checkmark, first.accessoryType, "first should be selected")
        XCTAssertEqual(.none, second.accessoryType, "second should not be selected")
    }

    func testSelectionUpdatesPresenter() {
        let indexPath = IndexPath(row: 0, section: 0)
        subject.tableView(subject.tableView, didSelectRowAt: indexPath)

        XCTAssertEqual("foo_meal", presenter.selectedMeal)
    }

    func testSelectionUpdatesSelectedIndex() {
        subject.tableView(subject.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(1, subject.selectedIndex)
    }

    func testSelectionReloadsIndexPaths() {
        subject.selectedIndex = 0
        let mockTableView = PartialMockTableView()
        subject.tableView = mockTableView

        subject.tableView(subject.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))

        let indexPathsToReload = [IndexPath(row: 1, section: 0), IndexPath(row: 0, section: 0)]
        XCTAssertEqual(indexPathsToReload, mockTableView.reloadedIndexPaths, "incorrect indexPaths were reloaded")
    }
}

// MARK: Test doubles
extension SelectMealViewControllerTests {
    class MockSelectMealPresenter: SelectMealPresenting {
        private(set) var loadMealsCalled = false
        private(set) var selectedMeal: String?

        func loadMeals() {
            loadMealsCalled = true
        }

        func select(mealTitle: String) {
            selectedMeal = mealTitle
        }

        func getSelectedMeal() -> String? {
            return selectedMeal
        }

        func loadTitle() {}
    }

    class PartialMockTableView: UITableView {
        private(set) var reloadedIndexPaths = [IndexPath]()
        override func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
            reloadedIndexPaths = indexPaths
        }
    }
}
