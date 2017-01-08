// MealPlan by Chirag Gupta

import Foundation

protocol UserDefaultsType {
    func set(_ value: Any?, forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
}

extension UserDefaults: UserDefaultsType {}
