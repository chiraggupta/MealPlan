// MealPlan by Chirag Gupta

import Foundation

struct MealViewData: Equatable {
    var day: String
    var title: String

    init(day: String, title: String?) {
        self.day = day
        self.title = title ?? ""
    }
}

func ==(lhs: MealViewData, rhs: MealViewData) -> Bool {
    return lhs.title == rhs.title && lhs.day == rhs.day
}
