// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class AddMealPresenterTests: QuickSpec {
    override func spec() {
        var subject: AddMealPresenter!
        let view = MockAddMealView()
        var model: MealsModel!

        beforeEach {
            model = MealsModel(contextProvider: FakeContextProvider())
            subject = AddMealPresenter(view: view, mealsProvider: model)
        }

        describe("done Tapped") {
            beforeEach {
                subject.doneTapped()
            }
            it("hides the view") {
                expect(view.hideModalCalled).to(beTrue())
            }
        }
    }
}

// MARK: Test doubles
extension AddMealPresenterTests {
    class MockAddMealView: AddMealViewType {
        private(set) var hideModalCalled = false
        func hideModal() {
            hideModalCalled = true
        }

        func display(_ viewController: UIViewController) {}
        func displayModally(_ viewController: UIViewController) {}
    }
}
