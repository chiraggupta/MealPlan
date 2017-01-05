// MealPlan by Chirag Gupta

import UIKit

protocol MealPlanView: class {
    func set(meals: [String])
}

class MealPlanViewController: UIViewController, MealPlanView {
    private var presenter: MealPlanPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = MealPlanPresenter(view: self)
    }

    func set(meals: [String]) {
    }
}
