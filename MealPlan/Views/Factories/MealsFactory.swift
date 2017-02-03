// MealPlan by Chirag Gupta

import UIKit

class MealsFactory: ViewControllerMaking {
    typealias ViewControllerType = MealsViewController

    var storyboardID = "Main"
    var viewControllerID = "MealsViewController"

    func makeViewController() -> UIViewController {
        let vc = instantiate()
        vc.presenter = MealsPresenter(view: vc)

        return UINavigationController(rootViewController: vc)
    }
}
