// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MockSelectMealPresenter: SelectMealPresenterType {
    private (set) fileprivate var loadMealsCalled = false
    private (set) fileprivate var selectCalled = false
    private (set) fileprivate var selectedMeal: String?

    func loadTitle() {}

    func loadMeals() {
        loadMealsCalled = true
    }

    func select(mealTitle: String) {
        selectCalled = true
        selectedMeal = mealTitle
    }

    func getSelectedMeal() -> String? {
        return selectedMeal
    }
}

class PartialMockTableView: UITableView {
    var reloadedIndexPaths = [IndexPath]()
    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        reloadedIndexPaths = indexPaths
    }
}

class SelectMealViewControllerTests: XCTestCase {
    var viewController: SelectMealViewController!
    var presenter = MockSelectMealPresenter()
    let meals = ["foo_meal", "bar_meal"]

    override func setUp() {
        viewController = makeViewController(storyboard: "Main")
        viewController.presenter = presenter

        viewController.set(meals: meals)
        viewController.display()
    }

    func testViewDidLoadLoadsMeals() {
        XCTAssertTrue(presenter.loadMealsCalled)
    }

    func testSetTitle() {
        viewController.set(title: "foobarbazqux")
        XCTAssertEqual("foobarbazqux", viewController.title, "view title not set correctly")
    }

    func testCountOfMealsInList() {
        let count = viewController.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(meals.count, count, "meals count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<meals.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(meals[i], cell.textLabel?.text, "meal \(i + 1) is incorrect")
            XCTAssertEqual(cell.accessoryType, .none, "cell shouldn't have a checkmark")
        }
    }

    func testSelectedMealsShowCheckmarks() {
        presenter.select(mealTitle: "foo_meal")
        let first = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let second = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(.checkmark, first.accessoryType, "first should be selected")
        XCTAssertEqual(.none, second.accessoryType, "second should not be selected")
    }

    func testSelectionUpdatesPresenter() {
        let indexPath = IndexPath(row: 0, section: 0)
        viewController.tableView(viewController.tableView, didSelectRowAt: indexPath)

        XCTAssertTrue(presenter.selectCalled)
        XCTAssertEqual("foo_meal", presenter.selectedMeal)
    }

    func testSelectionUpdatesSelectedIndex() {
        viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(1, viewController.selectedIndex)
    }

    func testSelectionReloadsIndexPaths() {
        viewController.selectedIndex = 0
        let mockTableView = PartialMockTableView()
        viewController.tableView = mockTableView

        viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))

        let indexPathsToReload = [IndexPath(row: 1, section: 0), IndexPath(row: 0, section: 0)]
        XCTAssertEqual(indexPathsToReload, mockTableView.reloadedIndexPaths, "incorrect indexPaths were reloaded")
    }
}
