// MealPlan by Chirag Gupta

extension MealEntity {
  func getListOfIngredients() -> [Ingredient] {
    return self.ingredients.allObjects
      .flatMap { $0 as? IngredientEntity }
      .flatMap { $0.name }
  }
}
