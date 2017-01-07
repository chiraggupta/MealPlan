// MealPlan by Chirag Gupta

import UIKit

protocol MealPlanViewType: class {
    func set(mealsViewData: [MealPlanViewData])
}

class MealPlanViewController: UIViewController, MealPlanViewType {
    @IBOutlet weak var tableView: UITableView!

    var presenter: MealPlanPresenterType!
    fileprivate var mealsViewData = [MealPlanViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealPlanPresenter(view: self)
        presenter.updateMealPlan()
    }

    func set(mealsViewData: [MealPlanViewData]) {
        self.mealsViewData = mealsViewData
    }
}

typealias TableViewImplementation = MealPlanViewController
extension TableViewImplementation: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "MealPlanCell")

        let mealViewData = mealsViewData[indexPath.row]
        cell.textLabel?.text = mealViewData.day
        cell.detailTextLabel?.text = mealViewData.title

        return cell
    }
}
