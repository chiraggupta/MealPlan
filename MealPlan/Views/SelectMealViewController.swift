// MealPlan by Chirag Gupta

import UIKit

protocol SelectMealViewType: class {
    func set(title: String)
    func set(meals: [String])
    var presenter: SelectMealPresenterType! {get set}
}

class SelectMealViewController: UITableViewController {
    var presenter: SelectMealPresenterType!
    fileprivate var meals = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadTitle()
        presenter.loadMeals()
    }
}

typealias SelectMealViewTypeImplementation = SelectMealViewController
extension SelectMealViewTypeImplementation: SelectMealViewType {
    func set(title screenTitle: String) {
        title = screenTitle
        navigationController?.title = screenTitle
    }

    func set(meals: [String]) {
        self.meals = meals
    }
}

private typealias TableViewDataSource = SelectMealViewController
extension TableViewDataSource {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectMealCell", for: indexPath)
        cell.textLabel?.text = meals[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.select(mealTitle: meals[indexPath.row])
    }
}
