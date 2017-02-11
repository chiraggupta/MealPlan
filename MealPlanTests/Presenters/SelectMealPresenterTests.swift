// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class SelectMealPresenterTests: XCTestCase {
    var subject: SelectMealPresenter!
    let view = MockSelectMealView()
    var mealsModel: MealsProvider!
    var mealPlanModel: WeeklyMealPlanProvider!

    override func setUp() {
        super.setUp()

        mealsModel = MealsModel(persistentContainer: TestUtils.makeInMemoryPersistenContainer())
        mealPlanModel = WeeklyMealPlanModel(userDefaults: MockUserDefaults())
        subject = SelectMealPresenter(day: .monday, view: view, mealPlanProvider: mealPlanModel,
                                      mealsProvider: mealsModel)
    }

    func testLoadTitle() {
        subject.loadTitle()

        XCTAssertEqual("Monday", view.setTitleArgument, "view title not set to Monday")
    }

    func testShowMeals() {
        givenMeals(["foo_meal", "bar_meal"])

        subject.loadMeals()

        XCTAssertEqual(["foo_meal", "bar_meal"], view.setArguments, "incorrect meals were set")
    }

    func testSelectMeals() {
        givenMeals(["foo_meal", "bar_meal"])

        subject.select(mealTitle: "foo_meal")

        XCTAssertEqual([.monday: Meal(title: "foo_meal")], mealPlanModel.getWeeklyMealPlan(), "meal not selected")
    }

    func testSelectInvalidMeal() {
        givenMeals(["foo_meal"])

        subject.select(mealTitle: "bar_meal")

        XCTAssertEqual([:], mealPlanModel.getWeeklyMealPlan(), "meal should not be selected")
    }

    func testGetSelectedMeal() {
        mealPlanModel.select(meal: Meal(title: "foo_meal"), day: .monday)
        XCTAssertEqual("foo_meal", subject.getSelectedMeal(), "foo_meal should be selected")
    }

    func testGetSelectedMealWithEmptyMealPlan() {
        XCTAssertNil(subject.getSelectedMeal(), "no meal should be selected")
    }
}

// MARK: Test doubles
extension SelectMealPresenterTests {
    func givenMeals(_ meals: [String]) {
        for meal in meals {
            _ = mealsModel.add(meal: Meal(title: meal))
        }
    }

    class MockSelectMealView: SelectMealViewType {
        var presenter: SelectMealPresenting!

        private(set) var setTitleArgument = ""
        private(set) var setArguments = [String]()

        func set(title: String) {
            setTitleArgument = title
        }

        func set(meals: [String]) {
            setArguments = meals
        }
    }
}
