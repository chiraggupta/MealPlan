// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MealPlanPresenterTests: XCTestCase {
    private var subject: MealPlanPresenter!
    private let view = MockMealPlanView()
    private var model: WeeklyMealPlanProvider!

    override func setUp() {
        super.setUp()

        model = WeeklyMealPlanModel(userDefaults: MockUserDefaults())
        model.select(meal: Meal(title: "foo_meal"), day: .monday)
        model.select(meal: Meal(title: "bar_meal"), day: .wednesday)
        model.select(meal: Meal(title: "baz_meal"), day: .saturday)

        subject = MealPlanPresenter(view: view, model: model)
    }

    func testUpdateMealPlanSetsMealPlanViewData() {
        let expectedViewData = [
            MealPlanViewData(day: .monday, title: "foo_meal"),
            MealPlanViewData(day: .tuesday, title: ""),
            MealPlanViewData(day: .wednesday, title: "bar_meal"),
            MealPlanViewData(day: .thursday, title: ""),
            MealPlanViewData(day: .friday, title: ""),
            MealPlanViewData(day: .saturday, title: "baz_meal"),
            MealPlanViewData(day: .sunday, title: "")
        ]

        subject.updateMealPlan()

        XCTAssertTrue(view.setCalled, "view meals were not set")
        XCTAssertEqual(expectedViewData, view.setArguments, "incorrect meals were set")
    }

    func testTappingMyMealsDisplaysMealsScreenModally() {
        subject.myMealsTapped()

        XCTAssertTrue(view.displayModallyCalled)
        XCTAssertTrue(view.displayedModally is UINavigationController)
        let topOfNavigation = (view.displayedModally as? UINavigationController)?.topViewController
        XCTAssertTrue(topOfNavigation is MealsViewController)
        let presenter = (topOfNavigation as? MealsViewController)?.presenter
        XCTAssertTrue(presenter is MealsPresenter)
    }

    func testTappingDayDisplaysSelectMealScreen() {
        subject.dayTapped(day: .monday)

        XCTAssertTrue(view.displayCalled)
        XCTAssertTrue(view.displayed is SelectMealViewController)
        let nextPresenter = (view.displayed as? SelectMealViewController)?.presenter
        XCTAssertTrue(nextPresenter is SelectMealPresenter)
        let selectedDay = (nextPresenter as? SelectMealPresenter)?.day
        XCTAssertEqual(.monday, selectedDay)
    }
}

// MARK: Test doubles
extension MealPlanPresenterTests {
    class MockMealPlanView: MealPlanViewType {
        private(set) var setCalled = false
        private(set) var setArguments = [MealPlanViewData]()
        private(set) var displayModallyCalled = false
        private(set) var displayedModally: UIViewController?
        private(set) var displayCalled = false
        private(set) var displayed: UIViewController?

        func set(mealPlanViewData: [MealPlanViewData]) {
            setCalled = true
            setArguments = mealPlanViewData
        }

        func display(_ viewController: UIViewController) {
            displayCalled = true
            displayed = viewController
        }

        func displayModally(_ viewController: UIViewController) {
            displayModallyCalled = true
            displayedModally = viewController
        }

        func hideModal() {}
    }
}
