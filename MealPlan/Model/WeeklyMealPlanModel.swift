// MealPlan by Chirag Gupta

import Foundation

typealias WeeklyMealPlan = [DayOfWeek: Meal]

protocol WeeklyMealPlanProvider {
    func getWeeklyMealPlan() -> WeeklyMealPlan
    func select(meal: Meal, day: DayOfWeek)
}

struct WeeklyMealPlanModel: WeeklyMealPlanProvider {
    private let meals: WeeklyMealPlan = [:]

    func getWeeklyMealPlan() -> WeeklyMealPlan {
        return meals
    }

    func select(meal: Meal, day: DayOfWeek) {
        print("Selected \(meal.title) for \(day.rawValue)")
    }
}
