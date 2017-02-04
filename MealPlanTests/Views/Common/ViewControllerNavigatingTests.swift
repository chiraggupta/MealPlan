// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class ViewControllerNavigatingTests: QuickSpec {
    override func spec() {
        describe("view controller navigation") {
            let subject = PartialMockViewController()
            let navigationController = PartialMockNavigation()
            let fooViewController = UIViewController()

            beforeEach {
                subject.customNavigationController = navigationController
            }

            context("when displayed") {
                beforeEach {
                    subject.display(fooViewController)
                }
                it("pushes fooViewController onto navigation stack") {
                    expect(navigationController.pushedViewController).to(equal(fooViewController))
                }
            }

            context("when displayed modally") {
                beforeEach {
                    subject.displayModally(fooViewController)
                }
                it("presents fooViewController") {
                    expect(subject.presented).to(equal(fooViewController))
                }
            }

            context("when closed") {
                beforeEach {
                    subject.hideModal()
                }
                it("dismisses self") {
                    expect(subject.dismissCalled).to(beTrue())
                }
            }
        }
    }

    class PartialMockNavigation: UINavigationController {
        private(set) var pushedViewController: UIViewController?
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
        }
    }

    class PartialMockViewController: UIViewController, ViewControllerNavigating {
        var customNavigationController: UINavigationController?
        override var navigationController: UINavigationController? {
            return customNavigationController
        }

        private(set) var presented: UIViewController?
        override func present(_ viewControllerToPresent: UIViewController,
                              animated flag: Bool, completion: (() -> Void)? = nil) {
            presented = viewControllerToPresent
        }

        private(set) var dismissCalled = false
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            dismissCalled = true
        }
    }
}
