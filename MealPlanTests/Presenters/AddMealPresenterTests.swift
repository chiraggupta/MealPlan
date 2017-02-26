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

        describe("meal name changed") {
            context("it is valid") {
                beforeEach {
                    subject.mealNameChanged(to: "dharma_canned_food")
                }
                it("updates the meal name") {
                    expect(subject.mealName).to(equal("dharma_canned_food"))
                }
                it("enables the save button on view") {
                    expect(view.saveButtonState).to(beTrue())
                }
            }
            context("it is invalid") {
                beforeEach {
                    subject.mealNameChanged(to: "")
                }
                it("updates the meal name") {
                    expect(subject.mealName).to(equal(""))
                }
                it("disables the save button on view") {
                    expect(view.saveButtonState).to(beFalse())
                }
            }
        }

        describe("cancel tapped") {
            beforeEach {
                subject.cancelTapped()
            }
            it("hides the view") {
                expect(view.hideModalCalled).to(beTrue())
            }
        }

        describe("save tapped") {
            beforeEach {
                subject.saveTapped()
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

        private(set) var saveButtonState: Bool?
        func setSaveButtonState(enabled: Bool) {
            saveButtonState = enabled
        }

        func display(_ viewController: UIViewController) {}
        func displayModally(_ viewController: UIViewController) {}
    }
}
