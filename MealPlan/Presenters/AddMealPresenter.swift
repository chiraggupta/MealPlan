// MealPlan by Chirag Gupta

import Foundation

protocol AddMealPresenting {
    func mealNameChanged(to newMealName: String)
    func saveTapped()
    func cancelTapped()
}

class AddMealPresenter: AddMealPresenting {
    unowned let view: AddMealViewType
    fileprivate let mealsProvider: MealsProvider

    var mealName = ""

    init(view: AddMealViewType, mealsProvider: MealsProvider) {
        self.view = view
        self.mealsProvider = mealsProvider
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
        mealsProvider.add(meal: Meal(name: mealName))
        view.hideModal()
    }
}
