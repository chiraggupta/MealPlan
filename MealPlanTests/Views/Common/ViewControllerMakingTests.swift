// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class ViewControllerMakingTests: QuickSpec {
  override func spec() {
    describe("instantiating a view controller") {
      context("of type MealPlan") {
        it("creates a view controller of the right type") {
          let factory = MealPlanFactory(contextProvider: FakeContextProvider())
          expect(factory.instantiate()).to(beAKindOf(MealPlanViewController.self))
        }
      }

      context("when the view controller is of a different type") {
        it("throws an error") {
          expect { () -> Void in _ = MixedUpViewControllerFactory().instantiate() }.to(throwAssertion())
        }
      }
    }
  }
}

extension ViewControllerMakingTests {
  class MixedUpViewControllerFactory: ViewControllerMaking {
    typealias ViewControllerType = MealPlanViewController

    let storyboardID = "Main"
    let viewControllerID = "MealsViewController"

    func makeViewController() -> UIViewController { return instantiate() }
  }
}
