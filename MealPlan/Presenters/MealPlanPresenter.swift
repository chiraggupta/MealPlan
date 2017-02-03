// MealPlan by Chirag Gupta

import Foundation

protocol MealPlanPresenting {
    func updateMealPlan()
    func myMealsTapped()
    func dayTapped(day: String)
}

class MealPlanPresenter: MealPlanPresenting {
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

    func myMealsTapped() {
        view.displayModally(MealsFactory().makeViewController())
    }

    func dayTapped(day: String) {
        guard let selectedDay = DayOfWeek(rawValue: day) else {
            NSLog("ERROR: Invalid day tapped \(day)")
            return
        }

        view.display(SelectMealFactory(day: selectedDay).makeViewController())
    }
}
