// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

struct MealsProviderStub: MealsProvider {
    let count: Int
    let duplicates: Int

    init(count: Int, duplicates: Int = 0) {
        self.count = count
        self.duplicates = duplicates < count ? duplicates : count

    }

    func getMeals() -> [Meal] {
        var meals = [Meal]()
        for i in 1...count {
            meals.append(Meal(title: "Meal \(i)"))
        }

        for i in 0..<duplicates {
            meals[i] = Meal(title: "Duplicate Meal")
        }
        return meals
    }

    func add(meal: Meal) {}
}

class WeeklyMealPlanModelTests: XCTestCase {
    private var model: WeeklyMealPlanProvider!

    func testWeeklyMealPlanWithMoreThanSevenMeals() {
        let expectedCount = 7

        model = WeeklyMealPlanModel(mealsModel: MealsProviderStub(count: 10))
        let count = model.getWeeklyMealPlan().count

        XCTAssertEqual(expectedCount, count)
    }

    func testWeeklyMealPlanWithLessThanSevenMeals() {
        let expectedCount = 2

        model = WeeklyMealPlanModel(mealsModel: MealsProviderStub(count: 2))
        let count = model.getWeeklyMealPlan().count

        XCTAssertEqual(expectedCount, count)
    }

    func testMealPlanShouldNotHaveDuplicates() {
        model = WeeklyMealPlanModel(mealsModel: MealsProviderStub(count: 10, duplicates: 4))
        let uniqueMeals = Set(model.getWeeklyMealPlan().values)

        XCTAssertEqual(7, uniqueMeals.count, "only \(uniqueMeals.count) unique")
    }
    
}
