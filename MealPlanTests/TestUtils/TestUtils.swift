// MealPlan by Chirag Gupta

import UIKit
import XCTest

func createVC(identifier: String, storyboard: String) -> UIViewController {
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: identifier)
}

extension UIViewController {
    func assertView() {
        XCTAssertNotNil(self.view, "\(self) failed to load")
    }
}
