// MealPlan by Chirag Gupta

import UIKit

protocol MealsView {
    func set(meals: [Meal])
}

class MealsViewController: UIViewController, MealsView {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func set(meals: [Meal]) {}
}
