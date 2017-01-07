// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealPlanPresenter: MealPlanPresenterType {
    fileprivate var view: MealPlanViewType
    fileprivate let stubMealsViewData = MealPlanProviderStub().getExpectedMealPlanViewData()

    init(view: MealPlanViewType) {
        self.view = view
    }

    func updateMealPlan() {
        view.set(mealsViewData: stubMealsViewData)
    }
}

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!
    var stubMealsViewData = [MealPlanViewData]()

    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealPlanViewController", storyboard: "Main") as! MealPlanViewController
        let mockPresenter = MockMealPlanPresenter(view: viewController)
        viewController.presenter = mockPresenter

        viewController.assertView()

        stubMealsViewData = mockPresenter.stubMealsViewData
    }

    func testCountOfMealsInList() {
        let count = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(stubMealsViewData.count, count, "meal list count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<stubMealsViewData.count {
            let expectedMealsViewData = stubMealsViewData[i]

            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(expectedMealsViewData.day, cell.textLabel?.text, "day \(i) is incorrect")
            XCTAssertEqual(expectedMealsViewData.title, cell.detailTextLabel?.text, "meal \(i) title is incorrect")
        }
    }
}
