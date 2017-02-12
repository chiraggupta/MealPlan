// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class MealsModelSpec: QuickSpec {
    override func spec() {
        var subject: MealsModel!
        beforeEach {
            subject = MealsModel(contextProvider: makeInMemoryPersistenContainer())
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
        }

        describe("removing meals") {
            let fooMeal = Meal(name: "foo_meal")
            let barMeal = Meal(name: "bar_meal")
            beforeEach {
                _ = subject.add(meal: fooMeal)
            }
            context("when the meal does not exist") {
                beforeEach {
                    subject.remove(meal: barMeal)
                }
                it("does nothing") {
                    expect(subject.getMeals()).to(equal([fooMeal]))
                }
            }
            context("when the meal exists") {
                beforeEach {
                    subject.remove(meal: fooMeal)
                }
                it("removes the meal") {
                    expect(subject.getMeals().count) == 0
                }
            }
        }
    }
}
