// MealPlan by Chirag Gupta

import UIKit

class AddMealFactory: ViewControllerMaking {
  private let contextProvider: ContextProviding

  init(contextProvider: ContextProviding) {
    self.contextProvider = contextProvider
  }

  typealias ViewControllerType = AddMealViewController

  var storyboardID = "Main"
  var viewControllerID = "AddMealViewController"

  func makeViewController() -> UIViewController {
    let vc = instantiate()
    let mealsModel = MealsModel(contextProvider: contextProvider)
    let ingredientsModel = IngredientsModel(contextProvider: contextProvider)
    vc.presenter = AddMealPresenter(view: vc, mealsProvider: mealsModel, ingredientsProvider: ingredientsModel)

    return UINavigationController(rootViewController: vc)
  }
}
