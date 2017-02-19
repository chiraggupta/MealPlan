// MealPlan by Chirag Gupta

import Foundation
import CoreData

typealias WeeklyMealPlan = [DayOfWeek: Meal]

protocol WeeklyMealPlanProvider {
    func getWeeklyMealPlan() -> WeeklyMealPlan
    func select(mealName: String, day: DayOfWeek)
}

struct WeeklyMealPlanModel: WeeklyMealPlanProvider {
    private let contextProvider: ContextProviding
    fileprivate var context: NSManagedObjectContext {
        return contextProvider.mainContext
    }

    init(contextProvider: ContextProviding) {
        self.contextProvider = contextProvider
    }

    func getWeeklyMealPlan() -> WeeklyMealPlan {
        var weekPlan = WeeklyMealPlan()

        let dayPlans = getStoredDayPlans()
        for dayPlan in dayPlans {
            if let day = dayPlan.day, let dayOfWeek = DayOfWeek(rawValue: day), let mealName = dayPlan.meal?.name {
                weekPlan[dayOfWeek] = Meal(name: mealName)
            }
        }

        return weekPlan
    }

    func select(mealName: String, day: DayOfWeek) {
        let mealsModel = MealsModel(contextProvider: contextProvider)

        guard let selectedMeal = mealsModel.getStoredMeal(name: mealName) else {
            assertionFailure("ERROR: Invalid meal \(mealName) selected.")
            return
        }

        if let dayPlan = getStoredDayPlan(day: day) {
            dayPlan.meal = selectedMeal
        } else {
            let newDayPlan = DayPlanEntity(context: context)
            newDayPlan.day = day.rawValue
            newDayPlan.meal = selectedMeal
        }

        Storage.saveContext(context)
    }
}

// MARK: Storage methods
extension WeeklyMealPlanModel {
    fileprivate func getStoredDayPlans() -> [DayPlanEntity] {
        return Storage.fetch(DayPlanEntity.fetchRequest(), context: context)
    }

    fileprivate func getStoredDayPlan(day: DayOfWeek) -> DayPlanEntity? {
        let request: NSFetchRequest<DayPlanEntity> = DayPlanEntity.fetchRequest()
        request.predicate = NSPredicate(format: "day == %@", day.rawValue)
        request.fetchLimit = 1

        return Storage.fetch(request, context: context).first
    }
}
