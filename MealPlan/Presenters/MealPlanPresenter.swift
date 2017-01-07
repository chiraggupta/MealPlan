// MealPlan by Chirag Gupta

import Foundation

protocol MealPlanViewPresenter {
    init(view: MealPlanView, model: WeeklyMealPlanProvider)
    func showMeals()
}

class MealPlanPresenter: MealPlanViewPresenter {
    fileprivate let model: WeeklyMealPlanProvider
    let view: MealPlanView

    required init(view: MealPlanView, model: WeeklyMealPlanProvider = WeeklyMealPlanModel(mealsModel: MealsModel())) {
        self.view = view
        self.model = model
    }

    func showMeals() {
        view.set(mealPlan: model.getWeeklyMealPlan())
    }
}
