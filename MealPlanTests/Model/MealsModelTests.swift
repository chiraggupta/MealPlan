// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MealsModelTests : XCTestCase {

    func testGetAllMeals() {
        let mealsModel = MealsModel()
        XCTAssertEqual(
            [
                Meal(title: "Butter chicken and rice"),
                Meal(title: "Quesadillas"),
                Meal(title: "Burritos"),
                Meal(title: "Pizza"),
                Meal(title: "Rajma and rice"),
                Meal(title: "Momos"),
                Meal(title: "Broccoli pasta"),
                Meal(title: "Aloo paratha"),
                Meal(title: "Small potatoes with sausages"),
                Meal(title: "Biryani")
            ],
            mealsModel.getMeals(), "incorrect meals")
    }
    
}
