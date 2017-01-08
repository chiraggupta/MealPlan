// MealPlan by Chirag Gupta

import Foundation

protocol MealsProvider {
    func getMeals() -> [Meal]
}

struct MealsModel: MealsProvider {
    private let userDefaults: UserDefaultsType!
    private let key = "Meals"

    init(userDefaults: UserDefaultsType = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func getMeals() -> [Meal] {
        guard let storedMeals = userDefaults.object(forKey: key) as? [String] else {
            return []
        }

        var meals = [Meal]()
        for storedMeal in storedMeals {
            meals.append(Meal(title: storedMeal))
        }
        return meals
    }
}
