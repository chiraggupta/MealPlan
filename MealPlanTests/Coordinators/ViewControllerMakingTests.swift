// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class ViewControllerMakingTests: QuickSpec {
    override func spec() {
        describe("instantiating a view controller") {
            context("of type MealPlan") {
                it("creates a view controller of the right type") {
                    expect(MealPlanCoordinator().instantiate()).to(beAKindOf(MealPlanViewController.self))
                }
            }

            context("when the view controller is of a different type") {
                it("throws an error") {
                    expect { () -> Void in _ = MixedUpViewControllerMaker().instantiate() }.to(throwAssertion())
                }
            }
        }
    }

    class MixedUpViewControllerMaker: ViewControllerMaking {
        typealias ViewControllerType = MealPlanViewController

        var storyboardID = "Main"
        var viewControllerID = "MealsViewController"

        func make() -> UIViewController { return instantiate() }
    }
}
