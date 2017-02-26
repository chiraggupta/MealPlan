// MealPlan by Chirag Gupta

import Foundation

protocol AddMealPresenting {
    func doneTapped()
}

class AddMealPresenter: AddMealPresenting {
    unowned let view: AddMealViewType
    fileprivate let mealsProvider: MealsProvider

    init(view: AddMealViewType, mealsProvider: MealsProvider) {
        self.view = view
        self.mealsProvider = mealsProvider
    }

    func doneTapped() {
        view.hideModal()
    }
}
