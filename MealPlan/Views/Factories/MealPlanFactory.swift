// MealPlan by Chirag Gupta

import UIKit

class MealPlanFactory: ViewControllerMaking {
  private let contextProvider: ContextProviding

  init(contextProvider: ContextProviding) {
    self.contextProvider = contextProvider
  }

  typealias ViewControllerType = MealPlanViewController

  let storyboardID = "Main"
  let viewControllerID = "MealPlanViewController"

  func makeViewController() -> UIViewController {
    let vc = instantiate()
    let model = WeeklyMealPlanModel(contextProvider: contextProvider)
    vc.presenter = MealPlanPresenter(view: vc, mealPlanProvider: model, contextProvider: contextProvider)

    return UINavigationController(rootViewController: vc)
  }
}
