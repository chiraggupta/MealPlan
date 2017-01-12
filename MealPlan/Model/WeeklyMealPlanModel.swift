// MealPlan by Chirag Gupta

import Foundation

typealias WeeklyMealPlan = [DayOfWeek: Meal]

protocol WeeklyMealPlanProvider {
    func getWeeklyMealPlan() -> WeeklyMealPlan
    func select(meal: Meal, day: DayOfWeek)
}

struct WeeklyMealPlanModel: WeeklyMealPlanProvider {
    private let mealsModel: MealsProvider

    init(mealsModel: MealsProvider = MealsModel()) {
        self.mealsModel = mealsModel
    }

    func getWeeklyMealPlan() -> WeeklyMealPlan {
        var meals = mealsModel.getMeals().removingDuplicates()
        var mealPlan = WeeklyMealPlan()

        for day in DayOfWeek.all {
            guard let meal = meals.first else {
                break
            }
            mealPlan[day] = meal
            meals.removeFirst()
        }

        return mealPlan
    }

    func select(meal: Meal, day: DayOfWeek) {
        print("Selected \(meal.title) for \(day.rawValue)")
    }
}
