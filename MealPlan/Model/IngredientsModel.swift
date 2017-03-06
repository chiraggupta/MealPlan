// MealPlan by Chirag Gupta

import Foundation
import CoreData

typealias Ingredient = String

protocol IngredientsProvider {
  func getIngredients() -> [Ingredient]
}

struct IngredientsModel {
  private let contextProvider: ContextProviding
  fileprivate var context: NSManagedObjectContext {
    return contextProvider.mainContext
  }

  init(contextProvider: ContextProviding) {
    self.contextProvider = contextProvider
  }

  func add(ingredients: [Ingredient]) -> [IngredientEntity] {
    var storedIngredients = [IngredientEntity]()
    for ingredient in ingredients {
      let storedIngredient = add(ingredient: ingredient)
      storedIngredients.append(storedIngredient)
    }

    Storage.saveContext(context)
    return storedIngredients
  }
}

// MARK: IngredientsProvider conformance
extension IngredientsModel: IngredientsProvider {
  func getIngredients() -> [Ingredient] {
    let storedIngredients = Storage.fetch(IngredientEntity.fetchRequest(), context: context)
    return storedIngredients.flatMap { $0.name }
  }
}

// MARK: Private methods
extension IngredientsModel {
  fileprivate func add(ingredient: Ingredient) -> IngredientEntity {
    if let storedIngredient = getIngredient(ingredient) {
      return storedIngredient
    }

    let newIngredient = IngredientEntity(context: context)
    newIngredient.name = ingredient
    return newIngredient
  }

  fileprivate func getIngredient(_ ingredient: Ingredient) -> IngredientEntity? {
    let request: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
    request.predicate = NSPredicate(format: "name == %@", ingredient)
    request.fetchLimit = 1

    return Storage.fetch(request, context: context).first
  }
}
