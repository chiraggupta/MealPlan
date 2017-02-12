// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class IngredientsModelTests: QuickSpec {
    override func spec() {
        var subject: IngredientsModel!

        beforeEach {
            subject = IngredientsModel(contextProvider: makeInMemoryPersistenContainer())
        }

        describe("adding ingredients") {
            beforeEach {
                subject.add(ingredients: ["peanut cheese", "oil balls"])
            }
            it("stores the ingredients") {
                let ingredients = subject.getIngredients()
                expect(ingredients.count) == 2
                expect(ingredients).to(contain(["peanut cheese", "oil balls"]))
            }
            describe("adding duplicates") {
                beforeEach {
                    subject.add(ingredients: ["peanut cheese", "bitter balls"])
                }
                it("doesn't store the duplicates") {
                    let ingredients = subject.getIngredients()
                    expect(ingredients.count) == 3
                    expect(ingredients).to(contain(["peanut cheese", "oil balls", "bitter balls"]))
                }
            }
        }
    }
}
