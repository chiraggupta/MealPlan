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
    let contextProvider: ContextProviding

    init(contextProvider: ContextProviding, userDefaults: UserDefaultsType = UserDefaults.standard) {
        self.userDefaults = userDefaults
        self.contextProvider = contextProvider
    }

    func getWeeklyMealPlan() -> WeeklyMealPlan {
        let rawMealPlan = getMealPlanFromStorage()
        var mealPlan = WeeklyMealPlan()

        for day in DayOfWeek.all {
            if let mealTitle = rawMealPlan[day.rawValue] {
                mealPlan[day] = Meal(name: mealTitle)
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
        mealPlan[day.rawValue] = meal.name

        userDefaults.set(mealPlan, forKey: key)
    }
}
