// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class WeeklyMealPlanModelTests: XCTestCase {
    private var model: WeeklyMealPlanProvider!

    override func setUp() {
        super.setUp()

        model = WeeklyMealPlanModel()
    }

    func testDefaultWeeklyMealPlan() {
        XCTAssertEqual([:], model.getWeeklyMealPlan())
    }
}
