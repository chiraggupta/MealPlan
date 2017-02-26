// MealPlan by Chirag Gupta

import Foundation

protocol MealsPresenting {
    func updateMeals()
    func remove(mealName: String)
    func addTapped()
    func cancelTapped()
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

    func remove(mealName: String) {
        mealsProvider.remove(mealName: mealName)
        view.set(meals: mealsProvider.getMeals())
    }

    func addTapped() {
        let addMealFactory = AddMealFactory(contextProvider: contextProvider)
        view.displayModally(addMealFactory.makeViewController())
    }

    func cancelTapped() {
        view.hideModal()
    }
}
