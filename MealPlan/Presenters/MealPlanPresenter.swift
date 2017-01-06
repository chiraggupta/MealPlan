// MealPlan by Chirag Gupta

import Foundation

protocol MealPlanViewPresenter {
    init(view: MealPlanView, model: MealsProvider)
    func showMeals()
}

class MealPlanPresenter: MealPlanViewPresenter {
    fileprivate let model: MealsProvider
    let view: MealPlanView

    required init(view: MealPlanView, model: MealsProvider = MealsModel()) {
        self.view = view
        self.model = model
    }

    func showMeals() {
        view.set(meals: model.getMeals())
    }
}
