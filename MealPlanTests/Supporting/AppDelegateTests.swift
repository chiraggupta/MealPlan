// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class AppDelegateTests: QuickSpec {
    override func spec() {
        var root: UIViewController?
        var displayed: UIViewController?

        describe("root view controller on launch") {
            beforeEach {
                root = UIApplication.shared.keyWindow?.rootViewController
                displayed = (root as? UINavigationController)?.topViewController
            }

            it("is a UINavigationController") {
                expect(root).to(beAKindOf(UINavigationController.self))
            }

            it("embeds MealPlanViewController") {
                expect(displayed).to(beAKindOf(MealPlanViewController.self))
            }

            it("has a presenter of type MealPlanPresenter") {
                let presenter = (displayed as? MealPlanViewController)?.presenter
                expect(presenter).to(beAKindOf(MealPlanPresenter.self))
            }
        }
    }
}
