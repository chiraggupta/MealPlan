// MealPlan by Chirag Gupta

import Foundation

protocol MealPlanPresenting {
    func updateMealPlan()
    func myMealsTapped()
    func dayTapped(day: DayOfWeek)
}

class MealPlanPresenter: MealPlanPresenting {
    unowned let view: MealPlanViewType
    fileprivate let mealPlanProvider: WeeklyMealPlanProvider

    init(view: MealPlanViewType, mealPlanProvider: WeeklyMealPlanProvider) {
        self.view = view
        self.mealPlanProvider = mealPlanProvider
    }

    func updateMealPlan() {
        let mealPlan = mealPlanProvider.getWeeklyMealPlan()
        let weeklyMealData = createMealPlanViewData(from: mealPlan)
        view.set(mealPlanViewData: weeklyMealData)
    }

    func createMealPlanViewData(from mealPlan: WeeklyMealPlan) -> [MealPlanViewData] {
        return DayOfWeek.all.map { MealPlanViewData(day: $0, title:mealPlan[$0]?.title) }
    }

    func myMealsTapped() {
        view.displayModally(MealsFactory().makeViewController())
    }

    func dayTapped(day: DayOfWeek) {
        view.display(SelectMealFactory(day: day).makeViewController())
    }
}
