// MealPlan by Chirag Gupta

import UIKit

protocol MealsViewType: class {
    func set(meals: [Meal])
}

class MealsViewController: UIViewController, MealsViewType {
    var presenter: MealsPresenterType!
    fileprivate var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealsPresenter(view: self)
        presenter.updateMeals()
    }

    func set(meals: [Meal]) {
        self.meals = meals
    }
}
