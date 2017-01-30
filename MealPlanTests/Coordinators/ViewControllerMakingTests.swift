// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class ViewControllerMakingTests: QuickSpec {
    override func spec() {
        var subject: ViewControllerMakingTest!
        beforeEach {
            subject = ViewControllerMakingTest()
        }
        describe("making a view controller ") {
            context("when embedded in a navigation controller") {
                beforeEach {
                    subject.viewControllerID = "Navigation_MealPlanViewController"
                }

                it("makes it embedded in UINavigationController") {
                    expect(subject.viewController.navigationController).to(beAKindOf(UINavigationController.self))
                }
            }

            context("when it is not embedded in a navigation controller") {
                beforeEach {
                    subject.viewControllerID = "MealPlanViewController"
                }

                it("has no navigation controller") {
                    expect(subject.viewController.navigationController).to(beNil())
                }
            }

            context("when view controller doesn't exist in storyboard") {
                beforeEach {
                    subject.viewControllerID = "Foo"
                }

                it("raises an exception") {
                    expect(subject.viewController).to(raiseException())
                }
            }

            context("when it doesn't exist") {
                beforeEach {
                    subject.viewControllerID = "MealsViewController"
                }

                it("throws an error") {
                    expect { () -> Void in _ = subject.viewController }.to(throwAssertion())
                }
            }
        }
    }

    class ViewControllerMakingTest: ViewControllerMaking {
        typealias ViewControllerType = MealPlanViewController

        var storyboardID = "Main"
        var viewControllerID = ""

        lazy var  viewController: MealPlanViewController = self.instantiate()
    }
}
