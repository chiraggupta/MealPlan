// MealPlan by Chirag Gupta

import CoreData

enum Storage {
    static func fetch<EntityType>(_ fetchRequest: NSFetchRequest<EntityType>, context: NSManagedObjectContext)
        -> [EntityType] {
        var result = [EntityType]()
        do {
            result = try context.fetch(fetchRequest)
        } catch let error as NSError {
            assertionFailure("ERROR: fetch failed. \(error), \(error.userInfo)")
        }
        return result
    }

    static func saveContext(_ context: NSManagedObjectContext) {
        guard context.hasChanges else {
            return
        }

        do {
            try context.save()
        } catch let error as NSError {
            assertionFailure("ERROR: Saving context failed. \(error), \(error.userInfo)")
        }
    }
}
