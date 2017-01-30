// MealPlan by Chirag Gupta

import UIKit

protocol ViewControllerMaking {
    associatedtype ViewControllerType: UIViewController

    var storyboardID: String { get }
    var viewControllerID: String { get }

    var viewController: ViewControllerType { get }
}

extension ViewControllerMaking {
    func instantiate() -> ViewControllerType {
        let storyboard = UIStoryboard(name: storyboardID, bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: viewControllerID)

        if let topOfNavigation = (vc as? UINavigationController)?.topViewController {
            vc = topOfNavigation
        }

        guard let correctlyTypedVC = vc as? ViewControllerType else {
            fatalError("Expected view controller of type \(ViewControllerType.self)")
        }

        return correctlyTypedVC
    }
}
