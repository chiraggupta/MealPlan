// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

struct MealsProviderStub: MealsProvider {
    let count: UInt

    func getMeals() -> [Meal] {
        var meals = [Meal]()
        for i in 1...count {
            meals.append(Meal(title: "Meal \(i)"))
        }
        return meals
    }
}

class WeeklyMealPlanModelTests: XCTestCase {
    private var model: WeeklyMealPlanProvider!

    func getMealCount(from mealPlanProvider: WeeklyMealPlanProvider) -> Int {
        return mealPlanProvider.getWeeklyMealPlan().count
    }

    func testWeeklyMealPlanWithMoreThanSevenMeals() {
        let expectedCount = 7

        model = WeeklyMealPlanModel(mealsModel: MealsProviderStub(count: 10))
        let count = getMealCount(from: model)

        XCTAssertEqual(expectedCount, count)
    }

    func testWeeklyMealPlanWithLessThanSevenMeals() {
        let expectedCount = 2

        model = WeeklyMealPlanModel(mealsModel: MealsProviderStub(count: 2))
        let count = getMealCount(from: model)

        XCTAssertEqual(expectedCount, count)
    }
}
