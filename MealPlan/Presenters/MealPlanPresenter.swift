// MealPlan by Chirag Gupta

import Foundation

protocol MealPlanViewPresenter {
    func showMeals()
}

class MealPlanPresenter: MealPlanViewPresenter {
    unowned let view: MealPlanView
    fileprivate let model: WeeklyMealPlanProvider

    init(view: MealPlanView, model: WeeklyMealPlanProvider = WeeklyMealPlanModel()) {
        self.view = view
        self.model = model
    }

    func showMeals() {
        view.set(mealPlan: model.getWeeklyMealPlan())
    }
}
