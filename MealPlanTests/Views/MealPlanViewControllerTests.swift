// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealPlanPresenter: MealPlanPresenterType {
    fileprivate var view: MealPlanViewType
    fileprivate let stubMealPlanViewData = MealPlanProviderStub().getExpectedMealPlanViewData()

    init(view: MealPlanViewType) {
        self.view = view
    }

    func updateMealPlan() {
        view.set(mealPlanViewData: stubMealPlanViewData)
    }
}

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!
    var stubMealPlanViewData = [MealPlanViewData]()

    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealPlanViewController", storyboard: "Main") as! MealPlanViewController
        let mockPresenter = MockMealPlanPresenter(view: viewController)
        viewController.presenter = mockPresenter

        viewController.assertView()

        stubMealPlanViewData = mockPresenter.stubMealPlanViewData
    }

    func testCountOfMealsInList() {
        let count = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(stubMealPlanViewData.count, count, "meal list count is incorrect")
    }

    func testMealsDisplayedInList() {
        for i in 0..<stubMealPlanViewData.count {
            let expectedMealPlanViewData = stubMealPlanViewData[i]

            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(expectedMealPlanViewData.day, cell.textLabel?.text, "day \(i) is incorrect")
            XCTAssertEqual(expectedMealPlanViewData.title, cell.detailTextLabel?.text, "meal \(i) title is incorrect")
        }
    }
}
