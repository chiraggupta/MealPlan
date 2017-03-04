// MealPlan by Chirag Gupta

import UIKit

protocol AddMealViewType: ViewControllerNavigating {
    func setSaveButtonState(enabled: Bool)
    func reloadIngredients()
    func showDuplicateMealAlert()
}

class AddMealViewController: UIViewController {
    var presenter: AddMealPresenting!

    @IBOutlet weak var mealNameField: UITextField!
    @IBOutlet weak var ingredientField: UITextField!
    @IBOutlet weak var ingredientsCollection: UICollectionView!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        setSaveButtonState(enabled: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        mealNameField.becomeFirstResponder()
    }

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

    func reloadIngredients() {
        ingredientsCollection.reloadData()
    }

    func showDuplicateMealAlert() {
        let alert = UIAlertController(title: "Duplicate Meal",
                                      message: "A meal with the same name already exists.",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)

        present(alert, animated: true)
    }
}

// MARK: UITextField delegate
extension AddMealViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField != ingredientField {
            return true
        }

        if let ingredient = textField.text {
            presenter.ingredientAdded(ingredient)
        }

        textField.text = ""
        return true
    }
}

// MARK: Ingredients collectionview data source
extension AddMealViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.ingredients.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddIngredientCell", for: indexPath)
        guard let ingredientCell = cell as? AddIngredientCell else {
            fatalError("Expected AddIngredientCell")
        }
        ingredientCell.ingredientName.text = presenter.ingredients[indexPath.row]

        return ingredientCell
    }
}
