// MealPlan by Chirag Gupta

import Foundation

protocol MealsPresenting {
    func updateMeals()
    func add(meal: Meal)
    func remove(mealName: String)
    func addTapped()
    func doneTapped()
}

class MealsPresenter: MealsPresenting {
    unowned let view: MealsViewType
    fileprivate let mealsProvider: MealsProvider
    private let contextProvider: ContextProviding

    init(view: MealsViewType, mealsProvider: MealsProvider, contextProvider: ContextProviding) {
        self.view = view
        self.mealsProvider = mealsProvider
        self.contextProvider = contextProvider
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

    func addTapped() {
        let addMealFactory = AddMealFactory(contextProvider: contextProvider)
        view.displayModally(addMealFactory.makeViewController())
    }

    func doneTapped() {
        view.hideModal()
    }
}
