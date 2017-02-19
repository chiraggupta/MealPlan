// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class SelectMealPresenterTests: QuickSpec {
    override func spec() {
        var subject: SelectMealPresenter!
        let view = MockSelectMealView()
        var mealsProvider: MockMealsProvider!
        var mealPlanProvider: MockWeeklyMealPlanProvider!

        beforeEach {
            mealsProvider = MockMealsProvider()
            mealPlanProvider = MockWeeklyMealPlanProvider()
            subject = SelectMealPresenter(day: .wednesday, view: view, mealPlanProvider: mealPlanProvider,
                                          mealsProvider: mealsProvider)
        }

        describe("loading title") {
            beforeEach {
                subject.loadTitle()
            }
            it("sets the view title to selected day") {
                expect(view.setTitle).to(equal("Wednesday"))
            }
        }

        describe("loading meals") {
            beforeEach {
                mealsProvider.meals = [Meal(name: "wild_boar"), Meal(name: "empty_peanut_butter")]
                subject.loadMeals()
            }
            it("updates the view with the list of stored meals") {
                expect(view.setMeals).to(equal(["wild_boar", "empty_peanut_butter"]))
            }
        }

        describe("selecting meals") {
            beforeEach {
                subject.select(mealTitle: "wild_boar")
            }
            it("selects the right day") {
                expect(mealPlanProvider.selectedDay).to(equal(DayOfWeek.wednesday))
            }
            it("selects the right meal") {
                expect(mealPlanProvider.selectedMeal).to(equal("wild_boar"))
            }
        }

        describe("getting selected meal") {
            context("when there is a meal selected for the given day") {
                beforeEach {
                    mealPlanProvider.weeklyMealPlan = [.wednesday: Meal(name: "dharma_canned_food")]
                }
                it("returns the selected meal") {
                    expect(subject.getSelectedMeal()).to(equal("dharma_canned_food"))
                }
            }
            context("when there is no meal selected for the given day") {
                beforeEach {
                    mealPlanProvider.weeklyMealPlan = [.monday: Meal(name: "dharma_canned_food")]
                }
                it("returns nil") {
                    expect(subject.getSelectedMeal()).to(beNil())
                }
            }
            context("when the meal plan is empty") {
                beforeEach {
                    mealPlanProvider.weeklyMealPlan = WeeklyMealPlan()
                }
                it("returns nil") {
                    expect(subject.getSelectedMeal()).to(beNil())
                }
            }
        }
    }
}

// MARK: Test doubles
extension SelectMealPresenterTests {
    class MockSelectMealView: SelectMealViewType {
        var presenter: SelectMealPresenting!

        private(set) var setTitle = ""
        private(set) var setMeals = [String]()

        func set(title: String) {
            setTitle = title
        }

        func set(meals: [String]) {
            setMeals = meals
        }
    }

    class MockMealsProvider: MealsProvider {
        var meals = [Meal]()
        func getMeals() -> [Meal] {
            return meals
        }

        func add(meal: Meal) -> Bool { return false }
        func remove(mealName: String) {}
    }

    class MockWeeklyMealPlanProvider: WeeklyMealPlanProvider {
        var weeklyMealPlan = WeeklyMealPlan()
        var selectedMeal: String?
        var selectedDay: DayOfWeek?

        func getWeeklyMealPlan() -> WeeklyMealPlan {
            return weeklyMealPlan
        }

        func select(mealName: String, day: DayOfWeek) {
            selectedMeal = mealName
            selectedDay = day
        }
    }
}
