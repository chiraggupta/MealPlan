// MealPlan by Chirag Gupta

import UIKit

protocol ViewControllerMaking {
  associatedtype ViewControllerType: UIViewController

  var storyboardID: String { get }
  var viewControllerID: String { get }

  func makeViewController() -> UIViewController
}

extension ViewControllerMaking {
  func instantiate() -> ViewControllerType {
    let storyboard = UIStoryboard(name: storyboardID, bundle: Bundle.main)
    let vc = storyboard.instantiateViewController(withIdentifier: viewControllerID)

    guard let correctlyTypedVC = vc as? ViewControllerType else {
      fatalError("Expected view controller of type \(ViewControllerType.self)")
    }

    return correctlyTypedVC
  }
}
