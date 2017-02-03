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
            MealPlanViewData(day: "Monday", title: "foo_meal"),
            MealPlanViewData(day: "Tuesday", title: ""),
            MealPlanViewData(day: "Wednesday", title: "bar_meal"),
            MealPlanViewData(day: "Thursday", title: ""),
            MealPlanViewData(day: "Friday", title: ""),
            MealPlanViewData(day: "Saturday", title: "baz_meal"),
            MealPlanViewData(day: "Sunday", title: "")
        ]

        subject.updateMealPlan()

        XCTAssertTrue(view.setCalled, "view meals were not set")
        XCTAssertEqual(expectedViewData, view.setArguments, "incorrect meals were set")
    }

    func testConfigureSelectMeal() {
        let view = MockSelectMealView()
        subject.configureSelectMealView(view: view, day: "Monday")

        XCTAssertNotNil(view.presenter, "select meal presenter was not set")

        guard let selectMealPresenter = view.presenter as? SelectMealPresenter else {
            XCTFail("select meal presenter should be an instance of SelectMealPresenter")
            return
        }
        XCTAssertEqual(.monday, selectMealPresenter.day, "select meal presenter had wrong day set")
        XCTAssertTrue((selectMealPresenter.view as? MockSelectMealView) != nil,
                      "select meal presenter had a wrong view set")
    }

    func testConfigureSelectMealWithIncorrectDay() {
        let view = MockSelectMealView()
        subject.configureSelectMealView(view: view, day: "Amazingday")

        XCTAssertNil(view.presenter, "presenter should not be set")
    }

    func testConfigureSelectMealWithIncorrectViewType() {
        let view = FakeViewWithPresenter()
        subject.configureSelectMealView(view: view, day: "Monday")

        XCTAssertNil(view.presenter, "presenter should not be set")
    }

    func testTappingMyMealsDisplaysSomethingModally() {
        subject.myMealsTapped()

        XCTAssertTrue(view.displayModallyCalled)
        XCTAssertTrue(view.displayedModally is UINavigationController)
        let topOfNavigation = (view.displayedModally as? UINavigationController)?.topViewController
        XCTAssertTrue(topOfNavigation is MealsViewController)
        let presenter = (topOfNavigation as? MealsViewController)?.presenter
        XCTAssertTrue(presenter is MealsPresenter)
    }
}

// MARK: Test doubles
extension MealPlanPresenterTests {
    class MockMealPlanView: MealPlanViewType {
        private(set) fileprivate var setCalled = false
        private(set) fileprivate var setArguments = [MealPlanViewData]()
        private(set) fileprivate var displayModallyCalled = false
        private(set) fileprivate var displayedModally: UIViewController?

        func set(mealPlanViewData: [MealPlanViewData]) {
            setCalled = true
            setArguments = mealPlanViewData
        }

        func displayModally(_ viewController: UIViewController) {
            displayModallyCalled = true
            displayedModally = viewController
        }
    }

    class FakeViewWithPresenter {
        var presenter: MealPlanPresenter!
    }
}
