// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MockSelectMealView: SelectMealViewType {
    private(set) fileprivate var reloadCalled: Bool = false
    private(set) fileprivate var setCalled: Bool = false
    private(set) fileprivate var setArguments = [String]()

    func set(meals: [String]) {
        setCalled = true
        setArguments = meals
    }

    func reload() {
        reloadCalled = true
    }
}

class SelectMealPresenterTests: XCTestCase {
    var presenter: SelectMealPresenter!
    let view = MockSelectMealView()
    var mealsModel: MealsProvider!
    var mealPlanModel: WeeklyMealPlanProvider!

    override func setUp() {
        super.setUp()

        let defaults = MockUserDefaults()
        mealsModel = MealsModel(userDefaults: defaults)
        mealPlanModel = WeeklyMealPlanModel(userDefaults: defaults)
        presenter = SelectMealPresenter(view: view, mealPlanProvider: mealPlanModel, mealsProvider: mealsModel)
    }

    func givenMeals(_ meals: [String]) {
        for meal in meals {
            mealsModel.add(meal: Meal(title: meal))
        }
    }

    func givenMealPlan(_ mealPlan: [DayOfWeek: String]) {
        for (day, meal) in mealPlan {
            mealPlanModel.select(meal: Meal(title: meal), day: day)
        }
    }

    func testShowMeals() {
        givenMeals(["foo_meal", "bar_meal"])

        presenter.showMeals()

        XCTAssertTrue(view.setCalled, "view meals were not set")
        XCTAssertEqual(["foo_meal", "bar_meal"], view.setArguments, "incorrect meals were set")
        XCTAssertTrue(view.reloadCalled, "view was not reloaded")
    }

    func testSelectMeals() {
        givenMeals(["foo_meal", "bar_meal"])
        givenMealPlan([:])

        presenter.select(mealTitle: "foo_meal", day: "Monday")

        XCTAssertEqual([.monday: Meal(title: "foo_meal")], mealPlanModel.getWeeklyMealPlan(), "meal not selected")
    }

    func testSelectInvalidDate() {
        givenMeals(["foo_meal"])
        givenMealPlan([:])

        presenter.select(mealTitle: "foo_meal", day: "Amazingday")

        XCTAssertEqual([:], mealPlanModel.getWeeklyMealPlan(), "meal should not be selected")
    }

    func testSelectInvalidMeal() {
        givenMeals(["foo_meal"])
        givenMealPlan([:])

        presenter.select(mealTitle: "bar_meal", day: "Tuesday")

        XCTAssertEqual([:], mealPlanModel.getWeeklyMealPlan(), "meal should not be selected")
    }
}
