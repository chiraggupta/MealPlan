// MealPlan by Chirag Gupta

import Foundation

protocol MealsPresenterType {
    func updateMeals()
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
}
