// MealPlan by Chirag Gupta

import Foundation

protocol AddMealPresenting {
    func mealNameChanged(to newMealName: String)
    func saveTapped()
    func cancelTapped()
}

class AddMealPresenter: AddMealPresenting {
    unowned let view: AddMealViewType
    private let mealsProvider: MealsProvider
    private let ingredientsProvider: IngredientsProvider

    var mealName = ""

    init(view: AddMealViewType, mealsProvider: MealsProvider, ingredientsProvider: IngredientsProvider) {
        self.view = view
        self.mealsProvider = mealsProvider
        self.ingredientsProvider = ingredientsProvider
    }

    func mealNameChanged(to newMealName: String) {
        mealName = newMealName.trimmingCharacters(in: .whitespaces)

        let saveButtonState = mealName.characters.count > 0
        view.setSaveButtonState(enabled: saveButtonState)
    }

    func cancelTapped() {
        view.hideModal()
    }

    func saveTapped() {
        let mealAdded = mealsProvider.add(meal: Meal(name: mealName))
        if mealAdded {
            view.hideModal()
        } else {
            view.showDuplicateMealAlert()
        }
    }
}
