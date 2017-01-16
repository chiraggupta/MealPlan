// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class WeeklyMealPlanModelTests: XCTestCase {
    private var subject: WeeklyMealPlanProvider!
    let defaults = MockUserDefaults()

    override func setUp() {
        super.setUp()

        subject = WeeklyMealPlanModel(userDefaults: defaults)
    }

    func testDefaultWeeklyMealPlan() {
        XCTAssertEqual([:], subject.getWeeklyMealPlan())
    }

    func testSelectMeal() {
        let fooMeal = Meal(title: "foo_meal")
        subject.select(meal: fooMeal, day: .sunday)
        XCTAssertEqual([.sunday: fooMeal], subject.getWeeklyMealPlan())
    }

    func testSelectingSameDayShouldReplaceMeal() {
        let fooMeal = Meal(title: "foo_meal")
        let barMeal = Meal(title: "bar_meal")

        subject.select(meal: fooMeal, day: .sunday)
        subject.select(meal: barMeal, day: .sunday)

        XCTAssertEqual(1, subject.getWeeklyMealPlan().count)
        XCTAssertEqual([.sunday: barMeal], subject.getWeeklyMealPlan())
    }

}
