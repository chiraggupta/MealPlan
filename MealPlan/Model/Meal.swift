// MealPlan by Chirag Gupta

import Foundation

struct Meal: Equatable, Hashable {
    var title: String

    var hashValue: Int {
        return title.hashValue
    }
}

func ==(lhs: Meal, rhs: Meal) -> Bool {
    return lhs.title == rhs.title
}
