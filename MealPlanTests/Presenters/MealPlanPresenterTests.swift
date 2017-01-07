// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

struct MealPlanProviderWithTwoFakeMeals: WeeklyMealPlanProvider {
    init() {}

    init(mealsModel: MealsProvider) {}

    func getWeeklyMealPlan() -> WeeklyMealPlan {
        return [
            DayOfWeek.monday: Meal(title: "foo"),
            DayOfWeek.tuesday: Meal(title: "bar")
        ]
    }
}

class MockMealPlanView: MealPlanView {
    private(set) fileprivate var setCalled = false
    private(set) fileprivate var setArguments = WeeklyMealPlan()

    func set(mealPlan: WeeklyMealPlan) {
        setCalled = true
        setArguments = mealPlan
    }
}

class MealPlanPresenterTests: XCTestCase {
    private var presenter: MealPlanPresenter!
    private let mealPlanView = MockMealPlanView()
    private let model = MealPlanProviderWithTwoFakeMeals()

    override func setUp() {
        super.setUp()

        presenter = MealPlanPresenter(view: mealPlanView, model: model)
    }

    func testShowMealsCallsViewSetWithCorrectArguments() {
        presenter.showMeals()
        XCTAssertTrue(mealPlanView.setCalled, "set was not called")
        XCTAssertEqual(model.getWeeklyMealPlan(), mealPlanView.setArguments, "set was called with incorrect mealPlan")
    }
}
