// MealPlan by Chirag Gupta

import UIKit

protocol MealsViewType: class {
    func set(meals: [Meal])
}

class MealsViewController: UIViewController {
    var presenter: MealsPresenterType!
    fileprivate var meals = [Meal]()
    var alertActionCreator = AlertActionCreator()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealsPresenter(view: self)
        presenter.updateMeals()
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Meal", message: "Something that you cook regularly", preferredStyle: .alert)

        let saveAction = alertActionCreator.create(title: "Add", style: .default) { _ in
            if let meal = alertController.textFields?.first?.text {
                self.presenter.add(meal: Meal(title: meal))
                self.presenter.updateMeals()
            }
        }
        let cancelAction = alertActionCreator.create(title: "Cancel", style: .cancel, handler: nil)

        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

private typealias ViewTypeImplementation = MealsViewController
extension ViewTypeImplementation: MealsViewType {
    func set(meals: [Meal]) {
        self.meals = meals
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
