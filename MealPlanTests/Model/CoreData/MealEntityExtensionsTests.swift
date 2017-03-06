// MealPlan by Chirag Gupta

import Quick
import Nimble
import CoreData
@testable import MealPlan

class MealEntityExtensionsTests: QuickSpec {
  override func spec() {
    describe("getting meal ingredients") {
      var subject: MealEntity!
      var mainContext: NSManagedObjectContext!
      beforeEach {
        mainContext = makeInMemoryPersistenContainer().mainContext
        subject = MealEntity(context: mainContext)
      }

      context("when there are none") {
        it("gets an empty list") {
          expect(subject.getListOfIngredients()).to(equal([]))
        }
      }

      context("when there are some") {
        var ingredient: IngredientEntity!
        beforeEach {
          ingredient = IngredientEntity(context: mainContext)
          ingredient.name = "purplesalt"

          subject.addToIngredients(ingredient)
        }
        it("gets them") {
          expect(subject.getListOfIngredients()).to(contain("purplesalt"))
        }
      }
    }
  }
}
