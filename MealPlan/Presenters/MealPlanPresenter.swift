// MealPlan by Chirag Gupta

import Foundation

protocol MealPlanPresenterType {
    func showMeals()
}

class MealPlanPresenter: MealPlanPresenterType {
    unowned let view: MealPlanViewType
    fileprivate let model: WeeklyMealPlanProvider

    init(view: MealPlanViewType, model: WeeklyMealPlanProvider = WeeklyMealPlanModel()) {
        self.view = view
        self.model = model
    }

    func showMeals() {
        view.set(mealPlan: model.getWeeklyMealPlan())
    }
}
