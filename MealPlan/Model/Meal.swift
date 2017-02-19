// MealPlan by Chirag Gupta

import Foundation

struct Meal: Equatable {
    init(name: String) {
        self.name = name
        self.ingredients = []
    }

    let name: String
    let ingredients: [Ingredient]
}

func == (lhs: Meal, rhs: Meal) -> Bool {
    return lhs.name == rhs.name && lhs.ingredients == rhs.ingredients
}
