// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class AddMealViewControllerTests: QuickSpec {
    override func spec() {
        let contextProvider = FakeContextProvider()
        var subject: AddMealViewController!
        var presenter: MockAddMealPresenting!

        beforeEach {
            subject = AddMealFactory(contextProvider: contextProvider).instantiate()
            presenter = MockAddMealPresenting()
            subject.presenter = presenter

            subject.setAsRootViewController()
        }

        describe("initial state") {
            beforeEach {
                subject.viewDidAppear(false)
            }
            it("keyboard is open and focused on meal name") {
                expect(subject.mealNameField.isFirstResponder).to(beTrue())
            }
            it("save is disabled") {
                expect(subject.saveButton.isEnabled).to(beFalse())
            }
        }

        describe("meal name field changes") {
            beforeEach {
                subject.mealNameField.text = "blah"
                subject.mealNameChanged()
            }
            it("updates the presenter with new meal name") {
                expect(presenter.newMealName).to(equal("blah"))
            }
        }

        describe("tap on save") {
            beforeEach {
                subject.saveTapped(UIBarButtonItem())
            }
            it("passes it on to the presenter") {
                expect(presenter.saveTappedCalled).to(beTrue())
            }
        }

        describe("tap on cancel") {
            beforeEach {
                subject.cancelTapped(UIBarButtonItem())
            }
            it("passes it on to the presenter") {
                expect(presenter.cancelTappedCalled).to(beTrue())
            }
        }

        describe("save button state") {
            context("set to enabled") {
                beforeEach {
                    subject.setSaveButtonState(enabled: true)
                }
                it("enables the button") {
                    expect(subject.saveButton.isEnabled).to(beTrue())
                }
            }
            context("set to disabled") {
                beforeEach {
                    subject.setSaveButtonState(enabled: false)
                }
                it("disables the button") {
                    expect(subject.saveButton.isEnabled).to(beFalse())
                }
            }
        }

        describe("duplicate meal alert") {
            beforeEach {
                subject.showDuplicateMealAlert()
            }
            it("shows an alert") {
                expect(subject.presentedViewController).to(beAKindOf(UIAlertController.self))
                expect(subject.presentedViewController?.view).toNot(beNil())
            }
            describe("alert configuration") {
                var alert: UIAlertController?
                beforeEach {
                    alert = subject.presentedViewController as? UIAlertController
                }
                it("has the correct title") {
                    expect(alert?.title).to(equal("Duplicate Meal"))
                }
                it("has the correct text") {
                    expect(alert?.message).to(equal("A meal with the same name already exists."))
                }
                it("has one action which is OK") {
                    expect(alert?.actions.count) == 1
                    expect(alert?.actions.first?.title).to(equal("OK"))
                }
            }
        }

        describe("data was entered on one of the text fields") {
            var result = false
            var textField: UITextField!
            context("ingredient field") {
                beforeEach {
                    textField = subject.ingredientField
                    textField.text = "purple salt"
                    result = subject.textFieldShouldReturn(textField)
                }
                it("returns true") {
                    expect(result).to(beTrue())
                }
                it("adds the ingredient") {
                    expect(presenter.addedIngredient).to(equal("purple salt"))
                }
                it("resets the field") {
                    expect(textField.text).to(beEmpty())
                }
            }
            context("meal name field") {
                beforeEach {
                    textField = subject.mealNameField
                    textField.text = "dharma canned food"
                    result = subject.textFieldShouldReturn(textField)
                }
                it("returns true") {
                    expect(result).to(beTrue())
                }
                it("does not add an ingredient") {
                    expect(presenter.addedIngredient).to(beNil())
                }
                it("does not reset the field") {
                    expect(textField.text).toNot(beEmpty())
                }
            }
        }
    }
}

// MARK: Test doubles
extension AddMealViewControllerTests {
    class MockAddMealPresenting: AddMealPresenting {
        private(set) var newMealName: String?
        func mealNameChanged(to newMealName: String) {
            self.newMealName = newMealName
        }

        private(set) var saveTappedCalled = false
        func saveTapped() {
            saveTappedCalled = true
        }

        private(set) var cancelTappedCalled = false
        func cancelTapped() {
            cancelTappedCalled = true
        }

        private(set) var addedIngredient: Ingredient?
        func ingredientAdded(_ ingredient: Ingredient) {
            addedIngredient = ingredient
        }
    }
}
