// MealPlan by Chirag Gupta

import XCTest

@testable import MealPlan

class MealPlanViewControllerTests: XCTestCase {
    var viewController: MealPlanViewController!

    override func setUp() {
        super.setUp()

        viewController = createVC(identifier: "MealPlanViewController", storyboard: "Main") as! MealPlanViewController
        viewController.assertView()
    }

}
