// MealPlan by Chirag Gupta

import UIKit

protocol MealPlanViewType: class {
    func set(mealPlanViewData: [MealPlanViewData])
}

class MealPlanViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var presenter: MealPlanPresenterType!
    fileprivate var mealPlanViewData = [MealPlanViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealPlanPresenter(view: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.updateMealPlan()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectMealSegue" {
            guard let day = (sender as? UITableViewCell)?.textLabel?.text else {
                NSLog("ERROR: SelectMealSegue received an invalid sender cell")
                return
            }

            presenter.configureSelectMealView(view: segue.destination, day: day)
        }
    }
}

private typealias ViewTypeImplementation = MealPlanViewController
extension ViewTypeImplementation: MealPlanViewType {
    func set(mealPlanViewData: [MealPlanViewData]) {
        self.mealPlanViewData = mealPlanViewData
    }
}

private typealias TableViewDataSource = MealPlanViewController
extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealPlanViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealPlanCell", for: indexPath)

        let viewDataForDay = mealPlanViewData[indexPath.row]
        cell.textLabel?.text = viewDataForDay.day
        cell.detailTextLabel?.text = viewDataForDay.title

        return cell
    }
}
