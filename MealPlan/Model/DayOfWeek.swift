// MealPlan by Chirag Gupta

import Foundation

enum DayOfWeek: String {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"

    static let all = [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
    
    static func byIndex(_ index: Int) -> DayOfWeek {
        return all[index % all.count]
    }
}
