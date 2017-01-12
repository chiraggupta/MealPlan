// MealPlan by Chirag Gupta

import UIKit

protocol MealsViewType: class {
    func set(meals: [Meal])
    func reload()
}

class MealsViewController: UIViewController {
    var presenter: MealsPresenterType!
    var addMealAlertCreator: AlertCreator!

    @IBOutlet weak var tableView: UITableView!

    fileprivate var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealsPresenter(view: self)
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
        dismiss(animated: true, completion: nil)
    }
}

private typealias ViewTypeImplementation = MealsViewController
extension ViewTypeImplementation: MealsViewType {
    func set(meals: [Meal]) {
        self.meals = meals
    }

    func reload() {
        tableView.reloadData()
    }
}

private typealias TableViewDataSource = MealsViewController
extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MealsCell")
        cell.textLabel?.text = meals[indexPath.row].title

        return cell
    }
}
