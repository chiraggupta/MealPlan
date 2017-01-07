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
        let weeklyMealData = createMealPlanViewData(from: mealPlan)
        view.set(mealsViewData: weeklyMealData)
    }

    func createMealPlanViewData(from mealPlan: WeeklyMealPlan) -> [MealPlanViewData] {
        return DayOfWeek.all.map { MealPlanViewData(day: $0.rawValue, title:mealPlan[$0]?.title) }
    }
}
