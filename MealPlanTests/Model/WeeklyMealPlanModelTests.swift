// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class WeeklyMealPlanModelTests: XCTestCase {
    private var model: WeeklyMealPlanProvider!
    let defaults = MockUserDefaults()

    override func setUp() {
        super.setUp()

        model = WeeklyMealPlanModel(userDefaults: defaults)
    }

    func testDefaultWeeklyMealPlan() {
        XCTAssertEqual([:], model.getWeeklyMealPlan())
    }

    func testSelectMeal() {
        let fooMeal = Meal(title: "foo_meal")
        model.select(meal: fooMeal, day: .sunday)
        XCTAssertEqual([.sunday: fooMeal], model.getWeeklyMealPlan())
    }

    func testSelectingSameDayShouldReplaceMeal() {
        let fooMeal = Meal(title: "foo_meal")
        let barMeal = Meal(title: "bar_meal")

        model.select(meal: fooMeal, day: .sunday)
        model.select(meal: barMeal, day: .sunday)

        XCTAssertEqual(1, model.getWeeklyMealPlan().count)
        XCTAssertEqual([.sunday: barMeal], model.getWeeklyMealPlan())
    }

}
