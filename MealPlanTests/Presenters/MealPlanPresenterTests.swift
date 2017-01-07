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

    func getExpectedMealPlanViewData() -> [MealPlanViewData] {
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
}

class MockMealPlanView: MealPlanViewType {
    private(set) fileprivate var setCalled = false
    private(set) fileprivate var setArguments = [MealPlanViewData]()

    func set(mealPlanViewData: [MealPlanViewData]) {
        setCalled = true
        setArguments = mealPlanViewData
    }
}

class MealPlanPresenterTests: XCTestCase {
    private var presenter: MealPlanPresenter!
    private let view = MockMealPlanView()
    private let model = MealPlanProviderStub()

    override func setUp() {
        super.setUp()

        presenter = MealPlanPresenter(view: view, model: model)
    }

    func testUpdateMealPlanSetsMealPlanViewData() {
        presenter.updateMealPlan()
        XCTAssertTrue(view.setCalled, "set not called")
        XCTAssertEqual(model.getExpectedMealPlanViewData(), view.setArguments, "incorrect arguments")
    }
}
