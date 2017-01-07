// MealPlan by Chirag Gupta

import UIKit

protocol MealPlanViewType: class {
    func set(mealPlanViewData: [MealPlanViewData])
}

class MealPlanViewController: UIViewController, MealPlanViewType {
    @IBOutlet weak var tableView: UITableView!

    var presenter: MealPlanPresenterType!
    fileprivate var mealPlanViewData = [MealPlanViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealPlanPresenter(view: self)
        presenter.updateMealPlan()
    }

    func set(mealPlanViewData: [MealPlanViewData]) {
        self.mealPlanViewData = mealPlanViewData
    }
}

typealias TableViewImplementation = MealPlanViewController
extension TableViewImplementation: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealPlanViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "MealPlanCell")

        let viewDataForDay = mealPlanViewData[indexPath.row]
        cell.textLabel?.text = viewDataForDay.day
        cell.detailTextLabel?.text = viewDataForDay.title

        return cell
    }
}
