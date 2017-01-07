// MealPlan by Chirag Gupta

import UIKit

protocol MealPlanViewType: class {
    func set(meals: [MealViewData])
}

class MealPlanViewController: UIViewController, MealPlanViewType {
    @IBOutlet weak var tableView: UITableView!

    var presenter: MealPlanPresenterType!
    fileprivate var meals = [MealViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealPlanPresenter(view: self)
        presenter.showMeals()
    }

    func set(meals: [MealViewData]) {
        self.meals = meals
    }
}

typealias TableViewImplementation = MealPlanViewController
extension TableViewImplementation: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "MealPlanCell")

        let mealForDay = meals[indexPath.row]
        cell.textLabel?.text = mealForDay.day
        cell.detailTextLabel?.text = mealForDay.title

        return cell
    }
}
