// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class WeeklyMealPlanModelSpec: QuickSpec {
    override func spec() {
        var subject: WeeklyMealPlanProvider!
        var defaults: MockUserDefaults!

        beforeEach {
            defaults = MockUserDefaults()
            subject = WeeklyMealPlanModel(userDefaults: defaults)
        }

        describe("getting meal plan") {
            context("when there is no plan") {
                it("is empty") {
                    expect(subject.getWeeklyMealPlan()).to(equal([:]))
                }
            }
            context("when there is a meal plan") {
                beforeEach {
                    defaults.set(["Wednesday": "foo_meal",
                                  "Saturday": "bar_meal",
                                  "Sunday": "baz_meal"
                        ], forKey: "WeeklyMealPlan")
                }
                it("gets the meal plan") {
                    let expectedPlan = [DayOfWeek.wednesday: Meal(title: "foo_meal"),
                                        DayOfWeek.saturday: Meal(title: "bar_meal"),
                                        DayOfWeek.sunday: Meal(title: "baz_meal")]
                    expect(subject.getWeeklyMealPlan()).to(equal(expectedPlan))
                }
            }
        }

        describe("select a meal") {
            let fooMeal = Meal(title: "foo_meal")
            beforeEach {
                subject.select(meal: fooMeal, day: .monday)
            }
            it("has the right meal selected") {
                expect(subject.getWeeklyMealPlan()).to(equal([.monday: fooMeal]))
            }

            describe("select another meal for the same day") {
                let barMeal = Meal(title: "bar_meal")
                beforeEach {
                    subject.select(meal: barMeal, day: .monday)
                }
                it("changes the selected meal") {
                    expect(subject.getWeeklyMealPlan()).to(equal([.monday: barMeal]))
                }
            }
        }
    }
}
