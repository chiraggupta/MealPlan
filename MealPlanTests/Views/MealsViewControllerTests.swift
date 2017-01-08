// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MockMealsPresenter: MealsPresenterType {
    fileprivate var view: MealsViewType
    fileprivate let stubMeals = MealsProviderStub(count: 10).getMeals()

    init(view: MealsViewType) {
        self.view = view
    }

    func updateMeals() {
        view.set(meals: stubMeals)
    }

    func add(meal: Meal) {}
}

class MealsViewControllerTests: XCTestCase {
    var viewController: MealsViewController!
    var stubMeals = [Meal]()

    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealsViewController", storyboard: "Main") as! MealsViewController
        let mockPresenter = MockMealsPresenter(view: viewController)
        viewController.presenter = mockPresenter

        viewController.assertView()

        stubMeals = mockPresenter.stubMeals
    }

    func testCountOfMealsInList() {
        let count = viewController.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(10, count, "meals count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<stubMeals.count {
            let expectedMeal = stubMeals[i]

            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(expectedMeal.title, cell.textLabel?.text, "meal \(i + 1) is incorrect")
        }
    }    
}
