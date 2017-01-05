// MealPlan by Chirag Gupta

import Foundation

protocol MealPlanViewPresenter {
    init(view: MealPlanView, model: MealsModel)
    func showMeals()
}

class MealPlanPresenter: MealPlanViewPresenter {
    fileprivate let model: MealsModel
    let view: MealPlanView

    required init(view: MealPlanView, model: MealsModel = MealsModel()) {
        self.view = view
        self.model = model
    }

    func showMeals() {
        view.set(meals: model.getMeals())
    }
}
