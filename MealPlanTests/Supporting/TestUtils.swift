// MealPlan by Chirag Gupta

import UIKit
import XCTest
@testable import MealPlan

func makeViewController <T: UIViewController> (storyboard: String) -> T? {
    guard let identifier = NSStringFromClass(T.self).components(separatedBy: ".").last else {
        assertionFailure("Expected <module.classname>, got \(NSStringFromClass(T.self))")
        return nil
    }

    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
        assertionFailure("Couldn't find \(identifier) in \(storyboard).storyboard")
        return nil
    }

    return viewController
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
