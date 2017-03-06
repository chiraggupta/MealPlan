// MealPlan by Chirag Gupta

import UIKit

class MealsFactory: ViewControllerMaking {
  private let contextProvider: ContextProviding

  init(contextProvider: ContextProviding) {
    self.contextProvider = contextProvider
  }

  typealias ViewControllerType = MealsViewController

  var storyboardID = "Main"
  var viewControllerID = "MealsViewController"

  func makeViewController() -> UIViewController {
    let vc = instantiate()
    let model = MealsModel(contextProvider: contextProvider)
    vc.presenter = MealsPresenter(view: vc, mealsProvider: model, contextProvider: contextProvider)

    return UINavigationController(rootViewController: vc)
  }
}
