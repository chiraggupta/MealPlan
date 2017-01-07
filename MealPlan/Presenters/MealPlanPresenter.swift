// MealPlan by Chirag Gupta

import Foundation

protocol MealPlanPresenterType {
    func updateMealPlan()
}

class MealPlanPresenter: MealPlanPresenterType {
    unowned let view: MealPlanViewType
    fileprivate let model: WeeklyMealPlanProvider

    init(view: MealPlanViewType, model: WeeklyMealPlanProvider = WeeklyMealPlanModel()) {
        self.view = view
        self.model = model
    }

    func updateMealPlan() {
        let mealPlan = model.getWeeklyMealPlan()
        let weeklyMealData = createMealViewData(from: mealPlan)
        view.set(meals: weeklyMealData)
    }

    func createMealViewData(from mealPlan: WeeklyMealPlan) -> [MealViewData] {
        return DayOfWeek.all.map { MealViewData(day: $0.rawValue, title:mealPlan[$0]?.title) }
    }
}
