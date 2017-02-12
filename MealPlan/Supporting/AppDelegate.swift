// MealPlan by Chirag Gupta

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        return true
    }

    func setupRootViewController() {
        let persistentContainer = NSPersistentContainer.make()
        let rootFactory = MealPlanFactory(contextProvider: persistentContainer)
        let rootViewController = rootFactory.makeViewController()

        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
}
