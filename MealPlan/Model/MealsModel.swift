// MealPlan by Chirag Gupta

import Foundation

protocol MealsProvider {
    func getMeals() -> [Meal]
    func add(meal: Meal)
    func remove(meal: Meal)
}

struct MealsModel: MealsProvider {
    private let userDefaults: UserDefaultsType!
    let key = "Meals"

    init(userDefaults: UserDefaultsType = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func getMeals() -> [Meal] {
        let meals = getMealsFromStorage()

        return meals.map { Meal(title: $0) }
    }

    private func getMealsFromStorage() -> [String] {
        if let storedMeals = userDefaults.object(forKey: key) as? [String] {
            return storedMeals
        }
        return []
    }

    func add(meal: Meal) {
        let existingMeals = getMealsFromStorage()
        if existingMeals.contains(meal.title) {
            return
        }

        let updatedMeals = existingMeals + [meal.title]
        userDefaults.set(updatedMeals, forKey: key)
    }

    func remove(meal: Meal) {
        var meals = getMealsFromStorage()
        guard let position = meals.index(of: meal.title) else {
            return
        }

        meals.remove(at: position)
        userDefaults.set(meals, forKey: key)
    }
}
