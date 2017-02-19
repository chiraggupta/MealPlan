// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class MealPlanPresenterTests: QuickSpec {
    override func spec() {
        var subject: MealPlanPresenter!
        let view = MockMealPlanView()
        var mealPlanProvider: MockWeeklyMealPlanProvider!

        beforeEach {
            mealPlanProvider = MockWeeklyMealPlanProvider(weeklyMealPlan: [
                .monday: Meal(name: "island_boar"),
                .wednesday: Meal(name: "empty_peanut_butter"),
                .saturday: Meal(name: "dharma_canned_food")
                ])
            subject = MealPlanPresenter(view: view, mealPlanProvider: mealPlanProvider,
                                        contextProvider: FakeContextProvider())
        }

        describe("updating meal plan") {
            beforeEach {
                subject.updateMealPlan()
            }

            it("updates the view with formatted meal plan data") {
                let expectedViewData = [
                    MealPlanViewData(day: .monday, title: "island_boar"),
                    MealPlanViewData(day: .tuesday, title: ""),
                    MealPlanViewData(day: .wednesday, title: "empty_peanut_butter"),
                    MealPlanViewData(day: .thursday, title: ""),
                    MealPlanViewData(day: .friday, title: ""),
                    MealPlanViewData(day: .saturday, title: "dharma_canned_food"),
                    MealPlanViewData(day: .sunday, title: "")
                ]

                expect(view.setArguments).to(equal(expectedViewData))
            }
        }

        describe("tapping my meals") {
            var displayedViewController: UIViewController?
            beforeEach {
                subject.myMealsTapped()
            }
            it("shows MealsViewController embedded in a navigation controller") {
                expect(view.displayedModally).to(beAKindOf(UINavigationController.self))
                displayedViewController = (view.displayedModally as? UINavigationController)?.topViewController
                expect(displayedViewController).to(beAKindOf(MealsViewController.self))
            }
            it("sets the correct presenter on the displayed view") {
                let presenter = (displayedViewController as? MealsViewController)?.presenter
                expect(presenter).to(beAKindOf(MealsPresenter.self))
            }
        }

        describe("selecting a day") {
            beforeEach {
                subject.dayTapped(day: .wednesday)
            }
            it("shows SelectMealViewController") {
                expect(view.displayed).to(beAKindOf(SelectMealViewController.self))
            }
            it("configures the next presenter correctly") {
                let presenter = (view.displayed as? SelectMealViewController)?.presenter
                expect(presenter).to(beAKindOf(SelectMealPresenter.self))
                expect((presenter as? SelectMealPresenter)?.day).to(equal(DayOfWeek.wednesday))
            }
        }
    }
}

// MARK: Test doubles
extension MealPlanPresenterTests {
    class MockMealPlanView: MealPlanViewType {
        private(set) var setArguments = [MealPlanViewData]()
        private(set) var displayedModally: UIViewController?
        private(set) var displayed: UIViewController?

        func set(mealPlanViewData: [MealPlanViewData]) {
            setArguments = mealPlanViewData
        }

        func display(_ viewController: UIViewController) {
            displayed = viewController
        }

        func displayModally(_ viewController: UIViewController) {
            displayedModally = viewController
        }

        func hideModal() {}
    }

    struct MockWeeklyMealPlanProvider: WeeklyMealPlanProvider {
        let weeklyMealPlan: WeeklyMealPlan
        func getWeeklyMealPlan() -> WeeklyMealPlan {
            return weeklyMealPlan
        }

        func select(mealName: String, day: DayOfWeek) {}
    }
}
