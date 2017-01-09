// MealPlan by Chirag Gupta

import UIKit
import XCTest
@testable import MealPlan

func createVC(identifier: String, storyboard: String) -> UIViewController {
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: identifier)
}

extension UIViewController {
    func display() {
        UIApplication.shared.keyWindow?.rootViewController = self
    }
}

class MockUserDefaults: UserDefaultsType {
    var storage = [String: Any]()

    func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }

    func object(forKey defaultName: String) -> Any? {
        return storage[defaultName]
    }
}
