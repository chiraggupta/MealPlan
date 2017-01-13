// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MockSelectMealView: SelectMealViewType {
    private(set) fileprivate var setTitleCalled: Bool = false
    private(set) fileprivate var setTitleArgument = ""
    private(set) fileprivate var setCalled: Bool = false
    private(set) fileprivate var setArguments = [String]()

    func set(title: String) {
        setTitleCalled = true
        setTitleArgument = title
    }

    func set(meals: [String]) {
        setCalled = true
        setArguments = meals
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
        presenter = SelectMealPresenter(day: .monday, view: view, mealPlanProvider: mealPlanModel,
                                        mealsProvider: mealsModel)
    }

    func givenMeals(_ meals: [String]) {
        for meal in meals {
            mealsModel.add(meal: Meal(title: meal))
        }
    }

    func testLoadTitle() {
        presenter.loadTitle()

        XCTAssert(view.setTitleCalled, "view title not set")
        XCTAssertEqual("Select meal for Monday", view.setTitleArgument, "view title not set to Monday")
    }

    func testShowMeals() {
        givenMeals(["foo_meal", "bar_meal"])

        presenter.loadMeals()

        XCTAssertTrue(view.setCalled, "view meals were not set")
        XCTAssertEqual(["foo_meal", "bar_meal"], view.setArguments, "incorrect meals were set")
    }

    func testSelectMeals() {
        givenMeals(["foo_meal", "bar_meal"])

        presenter.select(mealTitle: "foo_meal")

        XCTAssertEqual([.monday: Meal(title: "foo_meal")], mealPlanModel.getWeeklyMealPlan(), "meal not selected")
    }

    func testSelectInvalidMeal() {
        givenMeals(["foo_meal"])

        presenter.select(mealTitle: "bar_meal")

        XCTAssertEqual([:], mealPlanModel.getWeeklyMealPlan(), "meal should not be selected")
    }
}
