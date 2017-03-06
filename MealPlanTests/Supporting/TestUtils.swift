// MealPlan by Chirag Gupta

import UIKit
import XCTest
import CoreData
@testable import MealPlan

extension UIViewController {
  func setAsRootViewController() {
    UIApplication.shared.keyWindow?.rootViewController = self
  }
}

func makeInMemoryPersistenContainer() -> NSPersistentContainer {
  let description = NSPersistentStoreDescription()
  description.type = NSInMemoryStoreType

  return NSPersistentContainer.make(descriptions: [description])
}

struct FakeContextProvider: ContextProviding {
  let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
}
