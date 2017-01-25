// MealPlan by Chirag Gupta

import UIKit

protocol ViewControllerMaking {
    associatedtype ViewControllerType

    var storyboardID: String { get }
    var viewControllerID: String { get }

    func makeViewController() -> ViewControllerType
    func configure(viewController: ViewControllerType)
}

extension ViewControllerMaking {
    func makeViewController() -> ViewControllerType {
        let viewController = instantiateViewController()
        configure(viewController: viewController)
        return viewController
    }

    private func instantiateViewController() -> ViewControllerType {
        let storyboard = UIStoryboard(name: storyboardID, bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID)

        if let topOfNavigation = (viewController as? UINavigationController)?.topViewController {
            viewController = topOfNavigation
        }

        guard let viewControllerOfCorrectType = viewController as? ViewControllerType else {
            fatalError("Expected view controller of type \(ViewControllerType.self)")
        }
        return viewControllerOfCorrectType
    }
}
