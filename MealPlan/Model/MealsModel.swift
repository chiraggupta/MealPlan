// MealPlan by Chirag Gupta

import Foundation

protocol MealsProvider {
    func getMeals() -> [Meal]
    func add(meal: Meal) -> Bool
    func remove(meal: Meal)
}

struct MealsModel: MealsProvider {
    fileprivate let userDefaults: UserDefaultsType!
    let key = "Meals"

    init(userDefaults: UserDefaultsType = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func getMeals() -> [Meal] {
        let meals = getMealsFromStorage()

        return meals.map { Meal(title: $0) }
    }

    func add(meal: Meal) -> Bool {
        let existingMeals = getMealsFromStorage()
        if existingMeals.contains(meal.title) {
            return false
        }

        let updatedMeals = existingMeals + [meal.title]
        userDefaults.set(updatedMeals, forKey: key)
        return true
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

// MARK: Storage methods
extension MealsModel {
    fileprivate func getMealsFromStorage() -> [String] {
        if let storedMeals = userDefaults.object(forKey: key) as? [String] {
            return storedMeals
        }
        return []
    }
}
