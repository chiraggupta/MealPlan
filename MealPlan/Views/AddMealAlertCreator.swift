// MealPlan by Chirag Gupta

import UIKit

protocol AlertCreator {
    func create(successHandler: @escaping (String) -> Void) -> UIAlertController
}

struct AddMealAlertCreator: AlertCreator {
    let actionCreator: AlertActionCreator

    init(actionCreator: AlertActionCreator = AlertActionCreator()) {
        self.actionCreator = actionCreator
    }

    func create(successHandler: @escaping (String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Add Meal",
                                                message: nil,
                                                preferredStyle: .alert)

        let addAction = actionCreator.create(title: "Add", style: .default) { _ in
            if let mealTitle = alertController.textFields?.first?.text {
                successHandler(mealTitle)
            }
        }
        let cancelAction = actionCreator.create(title: "Cancel", style: .cancel, handler: nil)

        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        return alertController
    }
}
