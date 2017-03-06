// MealPlan by Chirag Gupta

import Quick
import Nimble
import CoreData
@testable import MealPlan

class NSPersistentContainerTests: QuickSpec {
  override func spec() {
    var subject: NSPersistentContainer!
    context("has default descriptions") {
      beforeEach {
        subject = NSPersistentContainer.make()
      }

      it("is named MealPlan") {
        expect(subject.name).to(equal("MealPlan"))
      }

      it("has a view context of main concurrency type") {
        expect(subject.viewContext.concurrencyType)
          .to(equal(NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType))
      }
    }

    context("at a non existing location") {
      it("throws a fatal error") {
        let description = NSPersistentStoreDescription(url: URL(fileURLWithPath: "foo/bar"))

        expect { () -> Void in _ = NSPersistentContainer.make(descriptions: [description])}
          .to(throwAssertion())
      }
    }
  }
}
