// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class MealsModelSpec: QuickSpec {
    override func spec() {
        var subject: MealsModel!
        var defaults: MockUserDefaults!
        beforeEach {
            defaults = MockUserDefaults()
            subject = MealsModel(userDefaults: defaults)
        }

        describe("getting meals") {
            context("when there are no meals") {
                it("is empty") {
                    expect(subject.getMeals()).to(beEmpty())
                }
            }
            context("when meals are stored in a wrong way") {
                beforeEach {
                    defaults.set(["foo_meal": "bar_meal"], forKey: "Meals")
                }
                it("is empty") {
                    expect(subject.getMeals()).to(beEmpty())
                }
            }
            context("when there are meals") {
                beforeEach {
                    defaults.set(["foo_meal", "bar_meal"], forKey: "Meals")
                }
                it("gets all the meals") {
                    expect(subject.getMeals()).to(equal([Meal(title: "foo_meal"), Meal(title: "bar_meal")]))
                }
            }
        }

        describe("adding meals") {
            describe("first meal") {
                let firstMeal = Meal(title: "foo_meal")
                beforeEach {
                    subject.add(meal: firstMeal)
                }
                it("has one meal") {
                    expect(subject.getMeals().count).to(equal(1))
                }
                it("contains the first meal") {
                    expect(subject.getMeals()).to(contain(firstMeal))
                }
                describe("second meal") {
                    context("when it is a duplicate") {
                        beforeEach {
                            subject.add(meal: firstMeal)
                        }
                        it("has only one meal") {
                            expect(subject.getMeals().count).to(equal(1))
                        }
                    }
                    context("when it is not a duplicate") {
                        let secondMeal = Meal(title: "bar_meal")
                        beforeEach {
                            subject.add(meal: secondMeal)
                        }
                        it("has two meals") {
                            expect(subject.getMeals().count).to(equal(2))
                        }
                        it("contains the second meal") {
                            expect(subject.getMeals()).to(contain(secondMeal))
                        }
                    }
                }
            }
        }

        describe("removing meals") {
            let fooMeal = Meal(title: "foo_meal")
            let barMeal = Meal(title: "bar_meal")
            beforeEach {
                defaults.set(["foo_meal"], forKey: "Meals")
            }
            context("when the meal does not exist") {
                beforeEach {
                    subject.remove(meal: barMeal)
                }
                it("does nothing") {
                    expect(subject.getMeals()).to(equal([Meal(title: "foo_meal")]))
                }
            }
            context("when the meal exists") {
                beforeEach {
                    subject.remove(meal: fooMeal)
                }
                it("removes the meal") {
                    expect(subject.getMeals()).toNot(contain(fooMeal))
                }
            }
        }
    }
}
