// MealPlan by Chirag Gupta

import UIKit
import XCTest
@testable import MealPlan

extension UIViewController {
    func setAsRootViewController() {
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
