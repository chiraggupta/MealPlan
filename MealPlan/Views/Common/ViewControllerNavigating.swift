// MealPlan by Chirag Gupta

import UIKit

protocol ViewControllerNavigating: class {
    func display(_ viewController: UIViewController)
    func displayModally(_ viewController: UIViewController)

    func hideModal()
}

extension ViewControllerNavigating where Self: UIViewController {
    func display(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    func displayModally(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }

    func hideModal() {
        dismiss(animated: true)
    }
}
