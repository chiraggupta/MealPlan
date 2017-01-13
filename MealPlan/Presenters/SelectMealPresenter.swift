// MealPlan by Chirag Gupta

import Foundation

protocol SelectMealPresenterType {
    func showMeals()
    func select(mealTitle: String, day: String)
}

class SelectMealPresenter: SelectMealPresenterType {
    let view: SelectMealViewType!
    let mealPlanProvider: WeeklyMealPlanProvider!
    let mealsProvider: MealsProvider!

    init(view: SelectMealViewType, mealPlanProvider: WeeklyMealPlanProvider = WeeklyMealPlanModel(),
         mealsProvider: MealsProvider = MealsModel()) {
        self.view = view
        self.mealPlanProvider = mealPlanProvider
        self.mealsProvider = mealsProvider
    }

    func showMeals() {
        let meals = mealsProvider.getMeals().map {$0.title}
        view.set(meals: meals)
        view.reload()
    }

    func select(mealTitle: String, day: String) {
        guard let dayOfWeek = DayOfWeek(rawValue: day) else {
            NSLog("ERROR: Invalid day selected: \(day)")
            return
        }

        let meal = Meal(title: mealTitle)
        if !mealsProvider.getMeals().contains(meal) {
            NSLog("ERROR: Invalid meal selected: \(mealTitle)")
            return
        }

        mealPlanProvider.select(meal: meal, day: dayOfWeek)
    }
}
