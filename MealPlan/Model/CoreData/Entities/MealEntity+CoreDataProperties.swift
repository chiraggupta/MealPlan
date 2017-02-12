// MealPlan by Chirag Gupta

import CoreData

extension MealEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealEntity> {
        return NSFetchRequest<MealEntity>(entityName: "MealEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var dayPlans: NSSet?

}

// MARK: Generated accessors for dayPlans
extension MealEntity {

    @objc(addDayPlansObject:)
    @NSManaged public func addToDayPlans(_ value: DayPlanEntity)

    @objc(removeDayPlansObject:)
    @NSManaged public func removeFromDayPlans(_ value: DayPlanEntity)

    @objc(addDayPlans:)
    @NSManaged public func addToDayPlans(_ values: NSSet)

    @objc(removeDayPlans:)
    @NSManaged public func removeFromDayPlans(_ values: NSSet)

}
