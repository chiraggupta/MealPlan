// MealPlan by Chirag Gupta

import CoreData

extension MealEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealEntity> {
        return NSFetchRequest<MealEntity>(entityName: "MealEntity")
    }

    @NSManaged public var name: String?
}
