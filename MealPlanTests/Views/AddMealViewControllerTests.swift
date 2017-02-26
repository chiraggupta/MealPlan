// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class AddMealViewControllerTests: QuickSpec {
    override func spec() {
        let contextProvider = FakeContextProvider()
        var subject: AddMealViewController!
        var presenter: AddMealPresenting!

        beforeEach {
            subject = AddMealFactory(contextProvider: contextProvider).instantiate()
            presenter = AddMealPresenter(view: subject, mealsProvider: MealsModel(contextProvider: contextProvider))
            subject.presenter = presenter
            subject.setAsRootViewController()
        }
    }
}
