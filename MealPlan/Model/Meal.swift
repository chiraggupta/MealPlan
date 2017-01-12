// MealPlan by Chirag Gupta

import Foundation

struct Meal: Equatable {
    var title: String
}

func == (lhs: Meal, rhs: Meal) -> Bool {
    return lhs.title == rhs.title
}
