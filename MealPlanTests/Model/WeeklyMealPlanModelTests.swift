// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class WeeklyMealPlanModelTests: XCTestCase {

    private var model: WeeklyMealPlanProvider!

    func testWeeklyMealPlanShouldHaveSevenUniqueMeals() {
        model = WeeklyMealPlanModel(mealsModel: MealsModel())

        let uniqueMeals = Set(model.getWeeklyMealPlan().values)
        XCTAssertEqual(7, uniqueMeals.count, "meal plan doesn't have 7 unique meals")
    }

    func testWeeklyMealPlanWhenThereAreOnlyTwoMeals() {
        model = WeeklyMealPlanModel(mealsModel: MealsProviderWithTwoFakeMeals())

        let mealPlan = model.getWeeklyMealPlan()
        XCTAssertEqual(2, mealPlan.values.count, "meal plan doesn't have 2 meals")
    }
}
