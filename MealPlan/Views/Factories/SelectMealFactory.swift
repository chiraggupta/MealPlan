// MealPlan by Chirag Gupta

import UIKit

class SelectMealFactory: ViewControllerMaking {
    private let day: DayOfWeek

    init(day: DayOfWeek) {
        self.day = day
    }

    typealias ViewControllerType = SelectMealViewController

    var storyboardID = "Main"
    var viewControllerID = "SelectMealViewController"

    func makeViewController() -> UIViewController {
        let vc = instantiate()
        vc.presenter = SelectMealPresenter(day: day, view: vc, mealPlanProvider: WeeklyMealPlanModel(),
                                           mealsProvider: MealsModel())
        return vc
    }
}
