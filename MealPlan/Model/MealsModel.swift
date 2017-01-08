// MealPlan by Chirag Gupta

import Foundation

protocol MealsProvider {
    func getMeals() -> [Meal]
    func add(meal: Meal)
}

struct MealsModel: MealsProvider {
    private let userDefaults: UserDefaultsType!
    let key = "Meals"

    init(userDefaults: UserDefaultsType = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func getMeals() -> [Meal] {
        let storedMeals = getMealsFromStorage()

        var meals = [Meal]()
        for storedMeal in storedMeals {
            meals.append(Meal(title: storedMeal))
        }
        return meals
    }

    private func getMealsFromStorage() -> [String] {
        if let storedMeals = userDefaults.object(forKey: key) as? [String] {
            return storedMeals
        }
        return []
    }

    func add(meal: Meal) {
        let existingMeals = getMealsFromStorage()
        let updatedMeals = existingMeals + [meal.title]
        userDefaults.set(updatedMeals, forKey: key)
    }

}
