// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class MealsModelTests: QuickSpec {
    override func spec() {
        var subject: MealsModel!
        var contextProvider: ContextProviding!
        beforeEach {
            contextProvider = makeInMemoryPersistenContainer()
            subject = MealsModel(contextProvider: contextProvider)
        }

        describe("adding meals") {
            describe("first meal") {
                let firstMeal = Meal(name: "foo_meal")
                var result = false
                beforeEach {
                    result = subject.add(meal: firstMeal)
                }
                it("succeeds") {
                    expect(result).to(beTrue())
                }
                it("stores the first meal") {
                    expect(subject.getMeals()).to(equal([firstMeal]))
                }

                describe("saving behaviour") {
                    beforeEach {
                        contextProvider.mainContext.reset()
                    }

                    it("keeps updates after reset") {
                        expect(subject.getMeals()).to(equal([firstMeal]))
                    }
                }

                describe("second meal") {
                    context("when it is a duplicate") {
                        beforeEach {
                            result = subject.add(meal: firstMeal)
                        }
                        it("fails") {
                            expect(result).to(beFalse())
                        }
                        it("does not store anything new") {
                            expect(subject.getMeals()).to(equal([firstMeal]))
                        }
                    }
                    context("when it is not a duplicate") {
                        let secondMeal = Meal(name: "bar_meal")
                        beforeEach {
                            result = subject.add(meal: secondMeal)
                        }
                        it("succeeds") {
                            expect(result).to(beTrue())
                        }
                        it("stores both the meals") {
                            expect(subject.getMeals()).to(equal([firstMeal, secondMeal]))
                        }
                    }
                }
            }

            describe("meal with ingredients") {
                let meal = Meal(name: "foo_meal", ingredients: ["bluesalt", "purplesalt"])
                var result = false

                beforeEach {
                    result = subject.add(meal: meal)
                }
                it("succeeds") {
                    expect(result).to(beTrue())
                }
                it("stores the meal with ingredients") {
                    let ingredientsFromAddedMeal = subject.getMeals().first?.ingredients
                    expect(ingredientsFromAddedMeal).to(contain(["bluesalt", "purplesalt"]))
                }

                it("stores the ingredients") {
                    let ingredientsModel = IngredientsModel(contextProvider: contextProvider)
                    let storedIngredients = ingredientsModel.getIngredients()

                    expect(storedIngredients).to(contain(["bluesalt", "purplesalt"]))
                }
            }
        }

        describe("removing meals") {
            let fooMeal = Meal(name: "foo_meal")
            beforeEach {
                _ = subject.add(meal: fooMeal)
            }
            context("when the meal does not exist") {
                beforeEach {
                    subject.remove(mealName: "bar_meal")
                }
                it("does nothing") {
                    expect(subject.getMeals()).to(equal([fooMeal]))
                }
            }
            context("when the meal exists") {
                beforeEach {
                    subject.remove(mealName: "foo_meal")
                }
                it("removes the meal") {
                    expect(subject.getMeals().count) == 0
                }

                describe("saving behaviour") {
                    beforeEach {
                        contextProvider.mainContext.reset()
                    }

                    it("keeps updates after reset") {
                        expect(subject.getMeals().count) == 0
                    }
                }
            }
        }
    }
}
