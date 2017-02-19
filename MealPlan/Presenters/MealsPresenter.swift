// MealPlan by Chirag Gupta

import Foundation

protocol MealsPresenting {
    func updateMeals()
    func add(meal: Meal)
    func remove(mealName: String)
    func doneTapped()
}

class MealsPresenter: MealsPresenting {
    unowned let view: MealsViewType
    fileprivate let mealsProvider: MealsProvider

    init(view: MealsViewType, mealsProvider: MealsProvider) {
        self.view = view
        self.mealsProvider = mealsProvider
    }

    func updateMeals() {
        view.set(meals: mealsProvider.getMeals())
        view.reload()
    }

    func add(meal: Meal) {
        if mealsProvider.add(meal: meal) {
            updateMeals()
        }
    }

    func remove(mealName: String) {
        mealsProvider.remove(mealName: mealName)
        view.set(meals: mealsProvider.getMeals())
    }

    func doneTapped() {
        view.hideModal()
    }
}
