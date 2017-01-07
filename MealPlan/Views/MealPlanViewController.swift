// MealPlan by Chirag Gupta

import UIKit

protocol MealPlanViewType: class {
    func set(mealPlan: WeeklyMealPlan)
}

class MealPlanViewController: UIViewController, MealPlanViewType {
    @IBOutlet weak var tableView: UITableView!

    var presenter: MealPlanPresenterType!
    fileprivate var mealPlan = WeeklyMealPlan()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealPlanPresenter(view: self)
        presenter.showMeals()
    }

    func set(mealPlan: WeeklyMealPlan) {
        self.mealPlan = mealPlan
    }
}

typealias TableViewImplementation = MealPlanViewController
extension TableViewImplementation: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealPlan.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "MealPlanCell")

        let day = DayOfWeek.byIndex(indexPath.row)
        let meal = mealPlan[day]

        cell.textLabel?.text = day.rawValue
        cell.detailTextLabel?.text = meal?.title

        return cell
    }
}
