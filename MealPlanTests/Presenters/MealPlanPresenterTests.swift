// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

struct MealPlanProviderStub: WeeklyMealPlanProvider {
    let mealPlan: WeeklyMealPlan
    func getWeeklyMealPlan() -> WeeklyMealPlan {
        return mealPlan
    }
    func select(meal: Meal, day: DayOfWeek) {}
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
    private var model: WeeklyMealPlanProvider!
    private let view = MockMealPlanView()

    override func setUp() {
        super.setUp()

        model = MealPlanProviderStub(mealPlan: [
            .monday: Meal(title: "meal 1"),
            .wednesday: Meal(title: "meal 2"),
            .saturday: Meal(title: "meal 3")
            ])

        presenter = MealPlanPresenter(view: view, model: model)

    }

    func testUpdateMealPlanSetsMealPlanViewData() {
        let expectedViewData = [
            MealPlanViewData(day: "Monday", title: "meal 1"),
            MealPlanViewData(day: "Tuesday", title: ""),
            MealPlanViewData(day: "Wednesday", title: "meal 2"),
            MealPlanViewData(day: "Thursday", title: ""),
            MealPlanViewData(day: "Friday", title: ""),
            MealPlanViewData(day: "Saturday", title: "meal 3"),
            MealPlanViewData(day: "Sunday", title: "")
        ]

        presenter.updateMealPlan()

        XCTAssertTrue(view.setCalled, "set not called")
        XCTAssertEqual(expectedViewData, view.setArguments, "incorrect arguments")
    }
}
