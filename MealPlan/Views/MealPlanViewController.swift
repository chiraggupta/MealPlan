// MealPlan by Chirag Gupta

import UIKit

protocol MealPlanView: class {
    func set(meals: [String])
}

class MealPlanViewController: UIViewController, MealPlanView {
    @IBOutlet weak var tableView: UITableView!

    var presenter: MealPlanViewPresenter!
    fileprivate var meals = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = presenter ?? MealPlanPresenter(view: self)
        presenter.showMeals()
    }

    func set(meals: [String]) {
        self.meals = meals
    }
}

typealias TableViewImplementation = MealPlanViewController
extension TableViewImplementation: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
