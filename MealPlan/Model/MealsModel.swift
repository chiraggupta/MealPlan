// MealPlan by Chirag Gupta

import Foundation
import CoreData

protocol MealsProvider {
    func getMeals() -> [Meal]
    func add(meal: Meal) -> Bool
    func remove(meal: Meal)
}

struct MealsModel: MealsProvider {
    private let persistentContainer: NSPersistentContainer
    fileprivate var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    init(persistentContainer: NSPersistentContainer = NSPersistentContainer.make()) {
        self.persistentContainer = persistentContainer
    }

    func getMeals() -> [Meal] {
        let meals = getStoredMeals()

        return meals
            .flatMap { $0.name }
            .map { Meal(title: $0) }
    }

    func add(meal: Meal) -> Bool {
        if getStoredMeal(name: meal.title) != nil {
            return false
        }

        let newMeal = MealEntity(context: mainContext)
        newMeal.name = meal.title

        Storage.saveContext(mainContext)
        return true
    }

    func remove(meal: Meal) {
        guard let mealEntity = getStoredMeal(name: meal.title) else {
            return
        }

        mainContext.delete(mealEntity)
        Storage.saveContext(mainContext)
    }
}

// MARK: Storage methods
extension MealsModel {
    fileprivate func getStoredMeals() -> [MealEntity] {
        return Storage.fetch(MealEntity.fetchRequest(), context: mainContext)
    }

    fileprivate func getStoredMeal(name: String) -> MealEntity? {
        let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.fetchLimit = 1

        return Storage.fetch(request, context: mainContext).first
    }
}
