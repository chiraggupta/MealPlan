// MealPlan by Chirag Gupta

import Foundation

typealias WeeklyMealPlan = [DayOfWeek: Meal]

protocol WeeklyMealPlanProvider {
    func getWeeklyMealPlan() -> WeeklyMealPlan
    func select(meal: Meal, day: DayOfWeek)
}

struct WeeklyMealPlanModel: WeeklyMealPlanProvider {
    private let userDefaults: UserDefaultsType!
    let key = "WeeklyMealPlan"

    init(userDefaults: UserDefaultsType = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func getWeeklyMealPlan() -> WeeklyMealPlan {
        let rawMealPlan = getMealPlanFromStorage()
        var mealPlan = WeeklyMealPlan()

        for day in DayOfWeek.all {
            if let mealTitle = rawMealPlan[day.rawValue] {
                mealPlan[day] = Meal(title: mealTitle)
            }
        }

        return mealPlan
    }

    private func getMealPlanFromStorage() -> [String: String] {
        if let storedMealPlan = userDefaults.object(forKey: key) as? [String: String] {
            return storedMealPlan
        }
        return [:]
    }

    func select(meal: Meal, day: DayOfWeek) {
        var mealPlan = getMealPlanFromStorage()
        mealPlan[day.rawValue] = meal.title

        userDefaults.set(mealPlan, forKey: key)
    }
}
