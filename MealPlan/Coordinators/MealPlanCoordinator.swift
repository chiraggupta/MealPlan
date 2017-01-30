// MealPlan by Chirag Gupta

import Foundation

class MealPlanCoordinator: ViewControllerMaking {
    var storyboardID = "Main"
    var viewControllerID = "Navigation_MealPlanViewController"

    lazy var viewController: MealPlanViewController = self.makeViewController()

    private func makeViewController() -> MealPlanViewController {
        let vc: MealPlanViewController = instantiate()
        vc.presenter = MealPlanPresenter(view: vc)
        return vc
    }
}
