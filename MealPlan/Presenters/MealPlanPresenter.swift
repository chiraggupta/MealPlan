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
    private let contextProvider: ContextProviding

    init(view: MealPlanViewType, mealPlanProvider: WeeklyMealPlanProvider, contextProvider: ContextProviding) {
        self.view = view
        self.mealPlanProvider = mealPlanProvider
        self.contextProvider = contextProvider
    }

    func updateMealPlan() {
        let mealPlan = mealPlanProvider.getWeeklyMealPlan()
        let weeklyMealData = createMealPlanViewData(from: mealPlan)
        view.set(mealPlanViewData: weeklyMealData)
    }

    func createMealPlanViewData(from mealPlan: WeeklyMealPlan) -> [MealPlanViewData] {
        return DayOfWeek.all.map { MealPlanViewData(day: $0, title:mealPlan[$0]?.name) }
    }

    func myMealsTapped() {
        let mealsFactory = MealsFactory(contextProvider: contextProvider)
        view.displayModally(mealsFactory.makeViewController())
    }

    func dayTapped(day: DayOfWeek) {
        let selectMealFactory = SelectMealFactory(contextProvider: contextProvider, day: day)
        view.display(selectMealFactory.makeViewController())
    }
}
