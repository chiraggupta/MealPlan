// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class MealsModelTests: XCTestCase {
    var subject: MealsModel!
    let defaults = MockUserDefaults()

    override func setUp() {
        super.setUp()

        subject = MealsModel(userDefaults: defaults)
    }

    func testGetMealsWhenDefaultsAreNotSet() {
        XCTAssertEqual([], subject.getMeals(), "meals should be empty")
    }

    func testGetMealsWhenDefaultsAreSet() {
        defaults.set(["foo", "bar"], forKey: "Meals")
        let expectedMeals = [Meal(title: "foo"), Meal(title: "bar")]

        XCTAssertEqual(expectedMeals, subject.getMeals(), "meals should be foo and bar")
    }

    func testGetMealsWhenDefaultsAreSetToInvalidType() {
        defaults.set(["foo": "bar"], forKey: "Meals")

        XCTAssertEqual([], subject.getMeals(), "meals should be empty")
    }

    func testAddFirstMeal() {
        let meal = Meal(title: "foo")
        subject.add(meal: meal)

        let updatedMeals = subject.getMeals()

        XCTAssertEqual(1, updatedMeals.count)
        XCTAssertTrue(updatedMeals.contains(meal), "foo was not added")
    }

    func testAddSecondMeal() {
        let meal1 = Meal(title: "foo")
        let meal2 = Meal(title: "bar")
        subject.add(meal: meal1)
        subject.add(meal: meal2)

        let updatedMeals = subject.getMeals()

        XCTAssertEqual(2, updatedMeals.count)
        XCTAssertTrue(updatedMeals.contains(meal1), "foo was not added")
        XCTAssertTrue(updatedMeals.contains(meal2), "bar was not added")
    }

    func testAddDuplicateMeal() {
        let meal = Meal(title: "foo_meal")
        subject.add(meal: meal)
        subject.add(meal: meal)

        let updatedMeals = subject.getMeals()

        XCTAssertEqual(1, updatedMeals.count, "duplicate shouldn't be added")
    }

    func testRemoveMeal() {
        let meal = Meal(title: "foo_meal")
        subject.add(meal: meal)

        subject.remove(meal: meal)
        let updatedMeals = subject.getMeals()

        XCTAssertEqual(0, updatedMeals.count, "meal was not removed")
    }

    func testRemoveNonExistingMeal() {
        let meal = Meal(title: "foo_meal")
        subject.add(meal: meal)

        subject.remove(meal: Meal(title: "bar_meal"))
        let updatedMeals = subject.getMeals()

        XCTAssertEqual(1, updatedMeals.count, "meal shouldn't have been removed")
    }
}
