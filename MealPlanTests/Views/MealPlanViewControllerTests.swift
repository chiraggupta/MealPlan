// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MockMealPlanPresenter: MealPlanPresenterType {
    fileprivate var updateMealPlanCalled = false
    fileprivate var configureCalled = false
    fileprivate var configuredView: Any?
    fileprivate var configuredDay = ""

    func updateMealPlan() {
        updateMealPlanCalled = true
    }

    func configureSelectMealView(view: Any, day: String) {
        configureCalled = true
        configuredView = view
        configuredDay = day
    }
}

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!
    let presenter = MockMealPlanPresenter()

    override func setUp() {
        super.setUp()

        viewController = makeViewController(storyboard: "Main")
        viewController.presenter = presenter

        viewController.set(mealPlanViewData: stubMealPlanViewData())
        viewController.display()
    }

    func testViewDidLoadCallsPresenterUpdateMealPlan() {
        XCTAssertTrue(presenter.updateMealPlanCalled)
    }

    func testCountOfMealsInList() {
        let count = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(stubMealPlanViewData().count, count, "meal list count is incorrect")
    }

    func testMealsDisplayedInList() {
        let stubData = stubMealPlanViewData()
        for i in 0..<stubData.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)

            XCTAssertEqual(stubData[i].day, cell.textLabel?.text, "day \(i) is incorrect")
            XCTAssertEqual(stubData[i].title, cell.detailTextLabel?.text, "meal \(i) title is incorrect")
        }
    }

    func testSelectMealSegue() {
        let cell = UITableViewCell()
        cell.textLabel?.text = "foo_day"

        let segue = stubSelectMealSegue()

        viewController.prepare(for: segue, sender: cell)

        XCTAssertTrue(presenter.configureCalled, "configure cell was not called")
        XCTAssertEqual("foo_day", presenter.configuredDay, "configure cell day was incorrect")

        guard let view = presenter.configuredView as? UIViewController else {
            XCTFail("configure cell view was of incorrect type")
            return
        }

        XCTAssertEqual(segue.destination, view, "configure cell destination was incorrect")
    }

    func testSelectMealSegueWithEmptyCell() {
        viewController.prepare(for: stubSelectMealSegue(), sender: UITableViewCell())
        XCTAssertFalse(presenter.configureCalled, "configure cell should not be called")
    }
}

private typealias Stubs = MealPlanViewControllerTests
extension Stubs {
    func stubMealPlanViewData() -> [MealPlanViewData] {
        return [
            MealPlanViewData(day: "Monday", title: "meal 1"),
            MealPlanViewData(day: "Tuesday", title: ""),
            MealPlanViewData(day: "Wednesday", title: "meal 2"),
            MealPlanViewData(day: "Thursday", title: ""),
            MealPlanViewData(day: "Friday", title: ""),
            MealPlanViewData(day: "Saturday", title: "meal 3"),
            MealPlanViewData(day: "Sunday", title: "")
        ]
    }

    func stubSelectMealSegue() -> UIStoryboardSegue {
        let destination = UIViewController()
        destination.title = "foo_title"
        return UIStoryboardSegue(identifier: "SelectMealSegue", source: viewController, destination: destination)
    }
}
