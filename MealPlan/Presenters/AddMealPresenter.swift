// MealPlan by Chirag Gupta

import Foundation

protocol AddMealPresenting {
  func mealNameChanged(to newMealName: String)
  func ingredientAdded(_ ingredient: Ingredient)
  var ingredients: [Ingredient] { get }
  func saveTapped()
  func cancelTapped()
}

class AddMealPresenter: AddMealPresenting {
  unowned let view: AddMealViewType
  private let mealsProvider: MealsProvider
  private let ingredientsProvider: IngredientsProvider

  private(set) var mealName = ""
  private(set) var ingredients = [Ingredient]()

  init(view: AddMealViewType, mealsProvider: MealsProvider, ingredientsProvider: IngredientsProvider) {
    self.view = view
    self.mealsProvider = mealsProvider
    self.ingredientsProvider = ingredientsProvider
  }

  func mealNameChanged(to newMealName: String) {
    mealName = newMealName.trimmingCharacters(in: .whitespaces)

    let saveButtonState = mealName.characters.count > 0
    view.setSaveButtonState(enabled: saveButtonState)
  }

  func ingredientAdded(_ ingredient: Ingredient) {
    let ingredient = ingredient.trimmingCharacters(in: .whitespaces)
    if ingredient.isEmpty {
      return
    }

    if ingredients.contains(ingredient) {
      return
    }

    ingredients.append(ingredient)
    view.reloadIngredients()
  }

  func cancelTapped() {
    view.hideModal()
  }

  func saveTapped() {
    let mealAdded = mealsProvider.add(meal: Meal(name: mealName, ingredients: ingredients))
    if mealAdded {
      view.hideModal()
    } else {
      view.showDuplicateMealAlert()
    }
  }
}
