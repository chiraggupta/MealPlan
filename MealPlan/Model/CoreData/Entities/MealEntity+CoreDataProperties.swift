// MealPlan by Chirag Gupta

import CoreData

extension MealEntity {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<MealEntity> {
    return NSFetchRequest<MealEntity>(entityName: "MealEntity")
  }

  @NSManaged public var name: String
  @NSManaged public var dayPlans: NSSet?
  @NSManaged public var ingredients: NSSet

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

// MARK: Generated accessors for ingredients
extension MealEntity {

  @objc(addIngredientsObject:)
  @NSManaged public func addToIngredients(_ value: IngredientEntity)

  @objc(removeIngredientsObject:)
  @NSManaged public func removeFromIngredients(_ value: IngredientEntity)

  @objc(addIngredients:)
  @NSManaged public func addToIngredients(_ values: NSSet)

  @objc(removeIngredients:)
  @NSManaged public func removeFromIngredients(_ values: NSSet)

}
