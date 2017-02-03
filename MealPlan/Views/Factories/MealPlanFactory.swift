// MealPlan by Chirag Gupta

import UIKit

class MealPlanFactory: ViewControllerMaking {
    typealias ViewControllerType = MealPlanViewController

    let storyboardID = "Main"
    let viewControllerID = "MealPlanViewController"

    func makeViewController() -> UIViewController {
        let vc: MealPlanViewController = instantiate()
        vc.presenter = MealPlanPresenter(view: vc)

        return UINavigationController(rootViewController: vc)
    }
}
