// MealPlan by Chirag Gupta

import UIKit

class SelectMealFactory: ViewControllerMaking {
  private let contextProvider: ContextProviding
  private let day: DayOfWeek

  init(contextProvider: ContextProviding, day: DayOfWeek) {
    self.contextProvider = contextProvider
    self.day = day
  }

  typealias ViewControllerType = SelectMealViewController

  var storyboardID = "Main"
  var viewControllerID = "SelectMealViewController"

  func makeViewController() -> UIViewController {
    let vc = instantiate()
    let mealPlanModel = WeeklyMealPlanModel(contextProvider: contextProvider)
    let mealsModel = MealsModel(contextProvider: contextProvider)
    vc.presenter = SelectMealPresenter(day: day, view: vc, mealPlanProvider: mealPlanModel,
                                       mealsProvider: mealsModel)
    return vc
  }
}
