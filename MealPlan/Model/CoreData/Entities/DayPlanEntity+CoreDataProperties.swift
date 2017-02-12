// MealPlan by Chirag Gupta

import CoreData

extension DayPlanEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayPlanEntity> {
        return NSFetchRequest<DayPlanEntity>(entityName: "DayPlanEntity")
    }

    @NSManaged public var day: String?
    @NSManaged public var meal: MealEntity?

}
