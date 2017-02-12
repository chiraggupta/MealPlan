// MealPlan by Chirag Gupta

import CoreData

extension IngredientEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientEntity> {
        return NSFetchRequest<IngredientEntity>(entityName: "IngredientEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var meals: NSSet?

}

// MARK: Generated accessors for meals
extension IngredientEntity {

    @objc(addMealsObject:)
    @NSManaged public func addToMeals(_ value: MealEntity)

    @objc(removeMealsObject:)
    @NSManaged public func removeFromMeals(_ value: MealEntity)

    @objc(addMeals:)
    @NSManaged public func addToMeals(_ values: NSSet)

    @objc(removeMeals:)
    @NSManaged public func removeFromMeals(_ values: NSSet)

}
