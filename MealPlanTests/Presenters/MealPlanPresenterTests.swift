// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

struct MealPlanProviderStub: WeeklyMealPlanProvider {
    func getWeeklyMealPlan() -> WeeklyMealPlan {
        return [
            DayOfWeek.monday: Meal(title: "meal 1"),
            DayOfWeek.wednesday: Meal(title: "meal 2"),
            DayOfWeek.saturday: Meal(title: "meal 3")
        ]
    }

    func getExpectedMealViewData() -> [MealViewData] {
        return [
            MealViewData(day: "Monday", title: "meal 1"),
            MealViewData(day: "Tuesday", title: ""),
            MealViewData(day: "Wednesday", title: "meal 2"),
            MealViewData(day: "Thursday", title: ""),
            MealViewData(day: "Friday", title: ""),
            MealViewData(day: "Saturday", title: "meal 3"),
            MealViewData(day: "Sunday", title: "")
        ]
    }
}

class MockMealPlanView: MealPlanViewType {
    private(set) fileprivate var setCalled = false
    private(set) fileprivate var setArguments = [MealViewData]()

    func set(meals: [MealViewData]) {
        setCalled = true
        setArguments = meals
    }
}

class MealPlanPresenterTests: XCTestCase {
    private var presenter: MealPlanPresenter!
    private let view = MockMealPlanView()
    private let modelStub = MealPlanProviderStub()

    override func setUp() {
        super.setUp()

        presenter = MealPlanPresenter(view: view, model: modelStub)
    }

    func testShowMealsSetsMealViewData() {
        presenter.showMeals()
        XCTAssertTrue(view.setCalled, "set not called")
        XCTAssertEqual(modelStub.getExpectedMealViewData(), view.setArguments, "incorrect arguments")
    }
}
