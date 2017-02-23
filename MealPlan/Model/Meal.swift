// MealPlan by Chirag Gupta

import Foundation

struct Meal: Equatable {
    init(name: String) {
        self.init(name: name, ingredients: [])
    }

    init(name: String, ingredients: [Ingredient]) {
        self.name = name
        self.ingredients = ingredients
    }

    let name: String
    let ingredients: [Ingredient]
}

func == (lhs: Meal, rhs: Meal) -> Bool {
    return lhs.name == rhs.name && lhs.ingredients == rhs.ingredients
}
