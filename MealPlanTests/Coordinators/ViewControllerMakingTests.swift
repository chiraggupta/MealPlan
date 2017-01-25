// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class ViewControllerMakingTests: QuickSpec {
    override func spec() {
        var subject: ViewControllerMakingClass!
        describe("a ViewControllerMaking class") {
            beforeEach {
                subject = ViewControllerMakingClass()
            }

            describe("making a view controller ") {
                context("when it is embedded in a navigation controller") {
                    beforeEach {
                        subject.viewControllerID = "Navigation_MealPlanViewController"
                    }

                    it("makes the right viewcontroller") {
                        let viewController = subject.makeViewController()
                        expect(viewController).to(beAKindOf(MealPlanViewController.self))
                        expect(viewController.navigationController).to(beAKindOf(UINavigationController.self))
                    }

                    it("configures the viewcontroller") {
                        expect(subject.makeViewController().title).to(equal("FooTitleConfigured"))
                    }
                }

                context("when it is not embedded in a navigation controller") {
                    beforeEach {
                        subject.viewControllerID = "MealPlanViewController"
                    }

                    it("makes the right viewcontroller") {
                        expect(subject.makeViewController()).to(beAKindOf(MealPlanViewController.self))
                    }
                }

                context("when view controller doesn't exist in storyboard") {
                    beforeEach {
                        subject.viewControllerID = "Foo"
                    }

                    it("raises an exception") {
                        expect(subject.makeViewController()).to(raiseException())
                    }
                }

                context("when it doesn't exist") {
                    beforeEach {
                        subject.viewControllerID = "MealsViewController"
                    }

                    it("throws an error") {
                        expect { () -> Void in _ = subject.makeViewController() }.to(throwAssertion())
                    }
                }
            }
        }
    }

    class ViewControllerMakingClass: ViewControllerMaking {
        typealias ViewControllerType = MealPlanViewController

        var storyboardID = "Main"
        var viewControllerID = ""
        
        func configure(viewController: MealPlanViewController) {
            viewController.title = "FooTitleConfigured"
        }
    }
}
