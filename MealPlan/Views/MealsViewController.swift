// MealPlan by Chirag Gupta

import UIKit

protocol MealsViewType: ViewControllerNavigating {
    func set(meals: [Meal])
    func reload()
}

class MealsViewController: UIViewController {
    var presenter: MealsPresenting!
    var addMealAlertCreator: AlertCreator!

    @IBOutlet weak var tableView: UITableView!

    fileprivate var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.updateMeals()
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        let alertCreator = addMealAlertCreator ?? AddMealAlertCreator()
        let alertController = alertCreator.create { mealTitle in
            self.addMealIfValid(title: mealTitle)
        }

        present(alertController, animated: true, completion: nil)
    }

    func addMealIfValid(title: String) {
        let trimmedMealTitle = title.trimmingCharacters(in: .whitespaces)
        if !trimmedMealTitle.isEmpty {
            presenter.add(meal: Meal(title: trimmedMealTitle))
        }
    }

    @IBAction func done(_ sender: UIBarButtonItem) {
        presenter.doneTapped()
    }
}

// MARK: MealsViewType conformance
extension MealsViewController: MealsViewType {
    func set(meals: [Meal]) {
        self.meals = meals
    }

    func reload() {
        tableView.reloadData()
    }
}

// MARK: TableView datasource
extension MealsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealsCell", for: indexPath)
        cell.textLabel?.text = meals[indexPath.row].title

        return cell
    }
}

// MARK: TableView delegate
extension MealsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            tableView.beginUpdates()

            presenter.remove(meal: meals[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)

            tableView.endUpdates()
        }
    }
}
