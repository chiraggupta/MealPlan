// MealPlan by Chirag Gupta

import Foundation

protocol MealPlanPresenterType {
    func updateMealPlan()
    func configureSelectMealView(view: Any, day: String)
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
        view.set(mealPlanViewData: weeklyMealData)
    }

    func createMealPlanViewData(from mealPlan: WeeklyMealPlan) -> [MealPlanViewData] {
        return DayOfWeek.all.map { MealPlanViewData(day: $0.rawValue, title:mealPlan[$0]?.title) }
    }

    func configureSelectMealView(view: Any, day: String) {
        guard let view = view as? SelectMealViewType else {
            NSLog("ERROR: configureSelectMeal should receive a view of type SelectMealViewType")
            return
        }

        guard let dayOfWeek = DayOfWeek(rawValue: day) else {
            NSLog("ERROR: configureSelectMeal received an invalid day: \(day)")
            return
        }

        let selectMealPresenter = SelectMealPresenter(day: dayOfWeek, view: view)
        view.presenter = selectMealPresenter
    }
}
