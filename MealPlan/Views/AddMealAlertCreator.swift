// MealPlan by Chirag Gupta

import UIKit

struct AddMealAlertCreator {
    let actionCreator: AlertActionCreator

    init(actionCreator: AlertActionCreator = AlertActionCreator()) {
        self.actionCreator = actionCreator
    }

    func create(addButtonHandler: @escaping (String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Add Meal",
                                                message: "Something that you cook regularly",
                                                preferredStyle: .alert)

        let addAction = actionCreator.create(title: "Add", style: .default) { _ in
            if let mealTitle = alertController.textFields?.first?.text {
                addButtonHandler(mealTitle)
            }
        }
        let cancelAction = actionCreator.create(title: "Cancel", style: .cancel, handler: nil)

        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        return alertController
    }
}
