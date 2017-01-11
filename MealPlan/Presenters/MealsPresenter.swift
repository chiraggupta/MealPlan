// MealPlan by Chirag Gupta

import Foundation

protocol MealsPresenterType {
    func updateMeals()
    func add(meal: Meal)
}

class MealsPresenter: MealsPresenterType {
    unowned let view: MealsViewType
    fileprivate let model: MealsProvider

    init(view: MealsViewType, model: MealsProvider = MealsModel()) {
        self.view = view
        self.model = model
    }

    func updateMeals() {
        view.set(meals: model.getMeals())
    }

    func add(meal: Meal) {
        model.add(meal: meal)
        updateMeals()
    }
}
