// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealPlanPresenter: MealPlanPresenterType {
    fileprivate var view: MealPlanViewType
    fileprivate let stubMealViewData = MealPlanProviderStub().getExpectedMealViewData()

    init(view: MealPlanViewType) {
        self.view = view
    }

    func updateMealPlan() {
        view.set(meals: stubMealViewData)
    }
}

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!
    var stubMealViewData = [MealViewData]()

    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealPlanViewController", storyboard: "Main") as! MealPlanViewController
        let mockPresenter = MockMealPlanPresenter(view: viewController)
        viewController.presenter = mockPresenter

        viewController.assertView()

        stubMealViewData = mockPresenter.stubMealViewData
    }

    func testCountOfMealsInList() {
        let count = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(stubMealViewData.count, count, "meal list count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<stubMealViewData.count {
            let expectedMealViewData = stubMealViewData[i]

            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(expectedMealViewData.day, cell.textLabel?.text, "day \(i) is incorrect")
            XCTAssertEqual(expectedMealViewData.title, cell.detailTextLabel?.text, "meal \(i) title is incorrect")
        }
    }
}
