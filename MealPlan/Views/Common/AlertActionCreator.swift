// MealPlan by Chirag Gupta

import UIKit

typealias AlertActionHandler = ((UIAlertAction) -> Void)

class AlertActionCreator {
    func create(title: String, style: UIAlertActionStyle, handler: AlertActionHandler?) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}