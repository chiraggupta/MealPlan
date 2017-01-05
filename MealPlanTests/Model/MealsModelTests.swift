// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MealsModelTests : XCTestCase {

    func testGetAllMeals() {
        let mealsModel = MealsModel()
        XCTAssertEqual(["Butter chicken and rice",
                        "Quesadilla",
                        "Pizza",
                        "Rajma and rice",
                        "Momos",
                        "Broccoli pasta",
                        "Aloo paratha"],
                       mealsModel.getMeals())
    }
    
}
