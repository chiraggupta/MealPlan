// MealPlan by Chirag Gupta

import Foundation

struct MealViewData: Equatable {
    var day: String
    var title: String
}

func ==(lhs: MealViewData, rhs: MealViewData) -> Bool {
    return lhs.title == rhs.title && lhs.day == rhs.day
}


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
        let mealPlan = model.getWeeklyMealPlan()
        let weeklyMealData = createMealViewData(from: mealPlan)
        view.set(meals: weeklyMealData)
    }

    func createMealViewData(from mealPlan: WeeklyMealPlan) -> [MealViewData] {
        var weeklyMealData = [MealViewData]()

        for day in DayOfWeek.all {
            let title = mealPlan[day]?.title ?? ""
            weeklyMealData.append(MealViewData(day: day.rawValue, title: title))
        }

        return weeklyMealData
    }
}
