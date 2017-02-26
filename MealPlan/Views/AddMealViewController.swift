// MealPlan by Chirag Gupta

import UIKit

protocol AddMealViewType: ViewControllerNavigating {
    func setSaveButtonState(enabled: Bool)
    func showDuplicateMealAlert()
}

class AddMealViewController: UIViewController {
    var presenter: AddMealPresenting!

    @IBOutlet weak var mealNameField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        presenter.cancelTapped()
    }

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        presenter.saveTapped()
    }

    @IBAction func mealNameChanged() {
        if let mealName = mealNameField.text {
            presenter.mealNameChanged(to: mealName)
        }
    }
}

// MARK: AddMealViewType conformance
extension AddMealViewController: AddMealViewType {
    func setSaveButtonState(enabled: Bool) {
        saveButton.isEnabled = enabled
    }

    func showDuplicateMealAlert() {

    }
}
