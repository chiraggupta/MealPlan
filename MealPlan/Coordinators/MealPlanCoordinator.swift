// MealPlan by Chirag Gupta

import UIKit

class MealPlanCoordinator: ViewControllerMaking {
    typealias ViewControllerType = MealPlanViewController

    let storyboardID = "Main"
    let viewControllerID = "MealPlanViewController"

    func make() -> UIViewController {
        let vc: MealPlanViewController = instantiate()
        vc.presenter = MealPlanPresenter(view: vc)

        return UINavigationController(rootViewController: vc)
    }
}
