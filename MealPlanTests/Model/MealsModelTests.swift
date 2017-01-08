// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MealsModelTests : XCTestCase {
    var mealsModel: MealsModel!
    let testDefaults = UserDefaultsMock()

    override func setUp() {
        super.setUp()

        mealsModel = MealsModel(userDefaults: testDefaults)
    }

    func testGetMealsWhenDefaultsAreNotSet() {
        XCTAssertEqual([], mealsModel.getMeals(), "meals should be empty")
    }

    func testGetMealsWhenDefaultsAreSet() {
        testDefaults.set(["foo", "bar"], forKey: "Meals")
        let expectedMeals = [Meal(title: "foo"), Meal(title: "bar")]

        XCTAssertEqual(expectedMeals, mealsModel.getMeals(), "meals should be foo and bar")
    }

    func testGetMealsWhenDefaultsAreSetToInvalidType() {
        testDefaults.set(["foo": "bar"], forKey: "Meals")

        XCTAssertEqual([], mealsModel.getMeals(), "meals should be empty")
    }

}
