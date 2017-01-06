// MealPlan by Chirag Gupta

import UIKit

protocol MealPlanView: class {
    func set(meals: [Meal])
}

class MealPlanViewController: UIViewController, MealPlanView {
    @IBOutlet weak var tableView: UITableView!

    var presenter: MealPlanViewPresenter!
    fileprivate var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealPlanPresenter(view: self)
        presenter.showMeals()
    }

    func set(meals: [Meal]) {
        self.meals = meals
    }
}

typealias TableViewImplementation = MealPlanViewController
extension TableViewImplementation: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MealPlanCell")
        cell.textLabel?.text = meals[indexPath.row].title
        return cell
    }
}
