// MealPlan by Chirag Gupta

import CoreData

extension NSPersistentContainer {
    static func make(descriptions: [NSPersistentStoreDescription] = []) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "MealPlan")

        if descriptions.count > 0 {
            container.persistentStoreDescriptions = descriptions
        }

        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                assertionFailure("ERROR: \(error), \(error.userInfo)")
            }
        }
        return container
    }
}
