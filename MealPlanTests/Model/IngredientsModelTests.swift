// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class IngredientsModelTests: QuickSpec {
  override func spec() {
    var subject: IngredientsModel!
    var contextProvider: ContextProviding!

    beforeEach {
      contextProvider = makeInMemoryPersistenContainer()
      subject = IngredientsModel(contextProvider: contextProvider)
    }

    describe("adding ingredients") {
      var result = [IngredientEntity]()
      beforeEach {
        result = subject.add(ingredients: ["peanut cheese", "oil balls"])
      }
      it("adds them") {
        let ingredients = subject.getIngredients()
        expect(ingredients.count) == 2
        expect(ingredients).to(contain(["peanut cheese", "oil balls"]))
      }
      it("returns the added ingredients") {
        expect(result.count) == 2
        expect(result[0].name).to(equal("peanut cheese"))
        expect(result[1].name).to(equal("oil balls"))
      }

      describe("saving behaviour") {
        beforeEach {
          contextProvider.mainContext.reset()
        }

        it("the added ingredients are persisted across resets") {
          let ingredients = subject.getIngredients()
          expect(ingredients.count) == 2
          expect(ingredients).to(contain(["peanut cheese", "oil balls"]))
        }
      }

      describe("adding duplicates") {
        beforeEach {
          result = subject.add(ingredients: ["peanut cheese", "bitter balls"])
        }
        it("doesn't store the duplicates") {
          let ingredients = subject.getIngredients()
          expect(ingredients.count) == 3
          expect(ingredients).to(contain(["peanut cheese", "oil balls", "bitter balls"]))
        }
        it("returns the added ingredients") {
          expect(result.count) == 2
          expect(result[0].name).to(equal("peanut cheese"))
          expect(result[1].name).to(equal("bitter balls"))
        }
      }
    }
  }
}
