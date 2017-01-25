// MealPlan by Chirag Gupta

import Foundation

class MealPlanCoordinator: ViewControllerMaking {
    typealias ViewControllerType = MealPlanViewController

    var storyboardID = "Main"
    var viewControllerID = "Navigation_MealPlanViewController"

    func configure(viewController: MealPlanViewController) {
        viewController.presenter = MealPlanPresenter(view: viewController)
    }
}
