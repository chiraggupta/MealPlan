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

    func testViewWillAppearCallsPresenterUpdateMealPlan() {
        viewController.viewWillAppear(false)
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
        let segue = makeSegue(identifier: "SelectMealSegue")

        viewController.prepare(for: segue, sender: makeCell(title: "foo_day"))

        XCTAssertTrue(presenter.configureCalled, "configure cell was not called")
        XCTAssertEqual("foo_day", presenter.configuredDay, "configure cell day was incorrect")

        guard let view = presenter.configuredView as? UIViewController else {
            XCTFail("configure cell view was of incorrect type")
            return
        }

        XCTAssertEqual(segue.destination, view, "configure cell destination was incorrect")
    }

    func testSelectMealSegueWithEmptyCell() {
        viewController.prepare(for: makeSegue(identifier: "SelectMealSegue"), sender: UITableViewCell())
        XCTAssertFalse(presenter.configureCalled, "configure cell should not be called")
    }

    func testIncorrectSegue() {
        viewController.prepare(for: makeSegue(identifier: "foo_segue"), sender: UITableViewCell())
        XCTAssertFalse(presenter.configureCalled, "configure cell should not be called")
    }
}

private typealias TestData = MealPlanViewControllerTests
extension TestData {
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

    func makeSegue(identifier: String) -> UIStoryboardSegue {
        let destination = UIViewController()
        destination.restorationIdentifier = "unique_foo"
        return UIStoryboardSegue(identifier: identifier, source: viewController, destination: destination)
    }

    func makeCell(title: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "foo_day"
        return cell
    }
}
