// MealPlan by Chirag Gupta

import UIKit

protocol SelectMealViewType: class {
  func set(title: String)
  func set(meals: [String])
  var presenter: SelectMealPresenting! {get set}
}

class SelectMealViewController: UITableViewController {
  var presenter: SelectMealPresenting!
  fileprivate var meals = [String]()
  var selectedIndex: Int?

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.loadTitle()
    presenter.loadMeals()
  }
}

// MARK: SelectMealViewType conformance
extension SelectMealViewController: SelectMealViewType {
  func set(title screenTitle: String) {
    title = screenTitle
    navigationController?.title = screenTitle
  }

  func set(meals: [String]) {
    self.meals = meals
  }
}

// MARK: TableView datasource
extension SelectMealViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return meals.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectMealCell", for: indexPath)
    let meal = meals[indexPath.row]
    cell.textLabel?.text = meal

    if meal == presenter.getSelectedMeal() {
      selectedIndex = indexPath.row
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }

    return cell
  }
}

// MARK: TableView delegate
extension SelectMealViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.select(mealTitle: meals[indexPath.row])

    var indexPathsToReload = [indexPath]
    if let oldIndex = selectedIndex {
      indexPathsToReload.append(IndexPath(row: oldIndex, section: 0))
    }

    tableView.reloadRows(at: indexPathsToReload, with: .automatic)
  }
}
