// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class WeeklyMealPlanModelTests: QuickSpec {
    override func spec() {
        let islandBoar = Meal(name: "island_boar")
        let dharmaCannedFood = Meal(name: "dharma_canned_food")
        let emptyPeanutButter = Meal(name: "empty_peanut_butter")

        var subject: WeeklyMealPlanProvider!
        var contextProvider: ContextProviding!

        beforeEach {
            contextProvider = makeInMemoryPersistenContainer()
            subject = WeeklyMealPlanModel(contextProvider: contextProvider)

            let mealsModel = MealsModel(contextProvider: contextProvider)
            _ = mealsModel.add(meal: islandBoar)
            _ = mealsModel.add(meal: dharmaCannedFood)
            _ = mealsModel.add(meal: emptyPeanutButter)
        }

        describe("getting the weekly plan") {
            context("when there is nothing selected") {
                it("is empty") {
                    expect(subject.getWeeklyMealPlan()).to(equal([:]))
                }
            }
            context("when meals are selected for multiple days") {
                beforeEach {
                    subject.select(meal: islandBoar, day: .wednesday)
                    subject.select(meal: dharmaCannedFood, day: .saturday)
                    subject.select(meal: emptyPeanutButter, day: .sunday)
                }
                it("gets the weekly meal plan") {
                    let expectedPlan = [DayOfWeek.wednesday: islandBoar,
                                        DayOfWeek.saturday: dharmaCannedFood,
                                        DayOfWeek.sunday: emptyPeanutButter]
                    expect(subject.getWeeklyMealPlan()).to(equal(expectedPlan))
                }
            }
        }

        describe("selecting a meal") {
            beforeEach {
                subject.select(meal: dharmaCannedFood, day: .monday)
            }
            it("updates the weekly meal plan") {
                expect(subject.getWeeklyMealPlan()).to(equal([.monday: dharmaCannedFood]))
            }

            describe("saving behaviour") {
                beforeEach {
                    contextProvider.mainContext.reset()
                }

                it("keeps updates after reset") {
                    expect(subject.getWeeklyMealPlan()).to(equal([.monday: dharmaCannedFood]))
                }
            }

            describe("selecting another meal for the same day") {
                beforeEach {
                    subject.select(meal: islandBoar, day: .monday)
                }
                it("replaces the existing meal") {
                    expect(subject.getWeeklyMealPlan()).to(equal([.monday: islandBoar]))
                }
            }

            describe("selecting a meal that does not exist in the database") {
                it("it throws an assertion") {
                    expect { () -> Void in _ = subject.select(meal: Meal(name: "fish_biscuits"), day: .monday) }
                        .to(throwAssertion())
                }
            }
        }
    }
}
