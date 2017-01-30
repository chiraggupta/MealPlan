// MealPlan by Chirag Gupta

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        return true
    }

    func setupRootViewController() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MealPlanCoordinator().viewController.navigationController
        self.window?.makeKeyAndVisible()
    }
}
