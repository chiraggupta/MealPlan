// MealPlan by Chirag Gupta

import Foundation
import CoreData

protocol ContextProviding {
    var mainContext: NSManagedObjectContext { get }
}

extension NSPersistentContainer: ContextProviding {
    var mainContext: NSManagedObjectContext {
        return viewContext
    }
}
