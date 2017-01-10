// MealPlan by Chirag Gupta

import Foundation

struct MealPlanViewData: Equatable {
    var day: String
    var title: String

    init(day: String, title: String?) {
        self.day = day
        self.title = title ?? ""
    }
}

func == (lhs: MealPlanViewData, rhs: MealPlanViewData) -> Bool {
    return lhs.title == rhs.title && lhs.day == rhs.day
}
