// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MealPlanViewControllerTests: XCTestCase {
    var subject: MealPlanViewController = MealPlanFactory().instantiate()
    let presenter = MockMealPlanPresenter()

    override func setUp() {
        super.setUp()

        subject.presenter = presenter

        subject.set(mealPlanViewData: stubMealPlanViewData())
        subject.setAsRootViewController()
    }

    func testViewWillAppearCallsPresenterUpdateMealPlan() {
        subject.viewWillAppear(false)
        XCTAssertTrue(presenter.updateMealPlanCalled)
    }

    func testCountOfMealsInList() {
        let count = subject.tableView(subject.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(stubMealPlanViewData().count, count, "meal list count is incorrect")
    }

    func testMealsDisplayedInList() {
        let stubData = stubMealPlanViewData()
        for i in 0..<stubData.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = subject.tableView(subject.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(stubData[i].day.rawValue, cell.textLabel?.text, "day \(i) is incorrect")
            XCTAssertEqual(stubData[i].title, cell.detailTextLabel?.text, "meal \(i) title is incorrect")
        }
    }

    func testMyMealsTappedCallsPresenter() {
        subject.myMealsTapped(UIBarButtonItem())

        XCTAssertTrue(presenter.myMealsTappedCalled)
    }

    func testSelectingTableviewCellSendsDaySelectedEvent() {
        let indexPath = IndexPath(row: 0, section: 0)
        subject.tableView(subject.tableView, didSelectRowAt: indexPath)

        XCTAssertEqual(.monday, presenter.dayTapped)
    }
}

// MARK: Test doubles
extension MealPlanViewControllerTests {
    class MockMealPlanPresenter: MealPlanPresenting {
        private(set) var updateMealPlanCalled = false
        private(set) var myMealsTappedCalled = false
        private(set) var dayTapped: DayOfWeek?

        func updateMealPlan() {
            updateMealPlanCalled = true
        }

        func myMealsTapped() {
            myMealsTappedCalled = true
        }

        func dayTapped(day: DayOfWeek) {
            dayTapped = day
        }
    }

    // Test data
    func stubMealPlanViewData() -> [MealPlanViewData] {
        return [
            MealPlanViewData(day: .monday, title: "meal 1"),
            MealPlanViewData(day: .tuesday, title: ""),
            MealPlanViewData(day: .wednesday, title: "meal 2"),
            MealPlanViewData(day: .thursday, title: ""),
            MealPlanViewData(day: .friday, title: ""),
            MealPlanViewData(day: .saturday, title: "meal 3"),
            MealPlanViewData(day: .sunday, title: "")
        ]
    }
}
