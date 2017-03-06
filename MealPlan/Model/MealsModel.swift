// MealPlan by Chirag Gupta

import Foundation
import CoreData

protocol MealsProvider {
  func getMeals() -> [Meal]
  func add(meal: Meal) -> Bool
  func remove(mealName: String)
}

struct MealsModel: MealsProvider {
  private let contextProvider: ContextProviding
  fileprivate var context: NSManagedObjectContext {
    return contextProvider.mainContext
  }

  private let ingredientsModel: IngredientsModel

  init(contextProvider: ContextProviding) {
    self.contextProvider = contextProvider
    ingredientsModel = IngredientsModel(contextProvider: contextProvider)
  }

  func getMeals() -> [Meal] {
    let storedMeals = getStoredMeals()
    return storedMeals.map { Meal(name: $0.name, ingredients: $0.getListOfIngredients()) }
  }

  func add(meal: Meal) -> Bool {
    if getStoredMeal(name: meal.name) != nil {
      return false
    }

    let newMeal = MealEntity(context: context)
    newMeal.name = meal.name

    let storedIngredients = ingredientsModel.add(ingredients: meal.ingredients)
    newMeal.addToIngredients(NSSet(array: storedIngredients))

    Storage.saveContext(context)
    return true
  }

  func remove(mealName: String) {
    guard let mealEntity = getStoredMeal(name: mealName) else {
      return
    }

    context.delete(mealEntity)
    Storage.saveContext(context)
  }
}

// MARK: Fetch request methods
extension MealsModel {
  fileprivate func getStoredMeals() -> [MealEntity] {
    return Storage.fetch(MealEntity.fetchRequest(), context: context)
  }

  func getStoredMeal(name: String) -> MealEntity? {
    let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
    request.predicate = NSPredicate(format: "name == %@", name)
    request.fetchLimit = 1

    return Storage.fetch(request, context: context).first
  }
}
