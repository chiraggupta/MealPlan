// MealPlan by Chirag Gupta

import UIKit

protocol SelectMealViewType: class {
    func set(title: String)
    func set(meals: [String])
    func reload()
}
