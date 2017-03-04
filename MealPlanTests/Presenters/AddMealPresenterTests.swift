// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class AddMealPresenterTests: QuickSpec {
    override func spec() {
        var subject: AddMealPresenter!
        var view: MockAddMealView!
        var model: MockMealsProvider!

        beforeEach {
            view = MockAddMealView()
            model = MockMealsProvider()
            let ingredientsModel = IngredientsModel(contextProvider: FakeContextProvider())
            subject = AddMealPresenter(view: view, mealsProvider: model, ingredientsProvider: ingredientsModel)
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
            context("it has whitespaces") {
                beforeEach {
                    subject.mealNameChanged(to: "  dharma canned food  \t")
                }
                it("trims and updates the meal name") {
                    expect(subject.mealName).to(equal("dharma canned food"))
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

        describe("adding ingredients") {
            context("it is valid") {
                beforeEach {
                    subject.ingredientAdded("purple salt")
                }
                it("adds to the list") {
                    expect(subject.ingredients).to(equal(["purple salt"]))
                }
                it("does not reload the view") {
                    expect(view.reloadIngredientsCalled).to(beTrue())
                }

                context("is a duplicate") {
                    beforeEach {
                        view = MockAddMealView()
                        subject.ingredientAdded("purple salt")
                    }
                    it("does not add to the list") {
                        expect(subject.ingredients).to(equal(["purple salt"]))
                    }
                    it("does not reload the view") {
                        expect(view.reloadIngredientsCalled).to(beFalse())
                    }
                }
            }
            context("it is blank") {
                beforeEach {
                    subject.ingredientAdded("")
                }
                it("does not add the ingredient") {
                    expect(subject.ingredients).to(beEmpty())
                }
            }
            context("it is has whitespaces") {
                beforeEach {
                    subject.ingredientAdded("    purple salt    ")
                }
                it("adds to the list after trimming whitespaces") {
                    expect(subject.ingredients).to(equal(["purple salt"]))
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
            context("adding meal succeeds") {
                beforeEach {
                    subject.mealNameChanged(to: "empty peanut butter")
                    subject.saveTapped()
                }
                it("saves the last updated meal") {
                    expect(model.addedMeal).to(equal(Meal(name: "empty peanut butter")))
                }
                it("hides the view") {
                    expect(view.hideModalCalled).to(beTrue())
                }
            }
            context("adding meal fails") {
                beforeEach {
                    model.addReturnValue = false
                    subject.saveTapped()
                }
                it("shows duplicate meal alert") {
                    expect(view.showDuplicateMealAlertCalled).to(beTrue())
                }
                it("does not hide the view") {
                    expect(view.hideModalCalled).to(beFalse())
                }
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

        private(set) var reloadIngredientsCalled = false
        func reloadIngredients() {
            reloadIngredientsCalled = true
        }

        private(set) var showDuplicateMealAlertCalled = false
        func showDuplicateMealAlert() {
            showDuplicateMealAlertCalled = true
        }

        func display(_ viewController: UIViewController) {}
        func displayModally(_ viewController: UIViewController) {}
    }

    class MockMealsProvider: MealsProvider {
        var addReturnValue = true
        private(set) var addedMeal: Meal?
        func add(meal: Meal) -> Bool {
            addedMeal = meal
            return addReturnValue
        }

        func getMeals() -> [Meal] { return [] }
        func remove(mealName: String) {}
    }
}
