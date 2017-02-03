// MealPlan by Chirag Gupta

import UIKit

protocol MealPlanViewType: class {
    func set(mealPlanViewData: [MealPlanViewData])
    func display(_ viewController: UIViewController)
    func displayModally(_ viewController: UIViewController)
}

class MealPlanViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var presenter: MealPlanPresenting!
    fileprivate var mealPlanViewData = [MealPlanViewData]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.updateMealPlan()
        tableView.reloadData()
    }

    @IBAction func myMealsTapped(_ sender: UIBarButtonItem) {
        presenter.myMealsTapped()
    }
}

// MARK: MealPlanViewType conformance
extension MealPlanViewController: MealPlanViewType {
    func set(mealPlanViewData: [MealPlanViewData]) {
        self.mealPlanViewData = mealPlanViewData
    }

    func display(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    func displayModally(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
}

// MARK: TableView datasource
extension MealPlanViewController: UITableViewDataSource {
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

// MARK: TableView delegate
extension MealPlanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDay = mealPlanViewData[indexPath.row].day
        presenter.dayTapped(day: selectedDay)
    }
}
