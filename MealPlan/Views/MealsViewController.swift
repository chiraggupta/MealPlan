// MealPlan by Chirag Gupta

import UIKit

protocol MealsViewType: class {
    func set(meals: [Meal])
}

class MealsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MealsPresenterType!
    fileprivate var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealsPresenter(view: self)
        presenter.updateMeals()
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
