// MealPlan by Chirag Gupta

import Foundation

protocol SelectMealPresenting {
  func loadTitle()
  func loadMeals()
  func select(mealTitle: String)
  func getSelectedMeal() -> String?
}

class SelectMealPresenter: SelectMealPresenting {
  let view: SelectMealViewType!
  let mealsProvider: MealsProvider!
  let mealPlanProvider: WeeklyMealPlanProvider!
  let day: DayOfWeek

  init(day: DayOfWeek, view: SelectMealViewType, mealPlanProvider: WeeklyMealPlanProvider,
       mealsProvider: MealsProvider) {
    self.day = day
    self.view = view
    self.mealsProvider = mealsProvider
    self.mealPlanProvider = mealPlanProvider
  }

  func loadTitle() {
    view.set(title: day.rawValue)
  }

  func loadMeals() {
    let meals = mealsProvider.getMeals().map {$0.name}
    view.set(meals: meals)
  }

  func select(mealTitle: String) {
    mealPlanProvider.select(mealName: mealTitle, day: day)
  }

  func getSelectedMeal() -> String? {
    return mealPlanProvider.getWeeklyMealPlan()[day]?.name
  }
}
