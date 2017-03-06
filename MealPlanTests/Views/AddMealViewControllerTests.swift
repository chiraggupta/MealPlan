// MealPlan by Chirag Gupta

import Quick
import Nimble
@testable import MealPlan

class AddMealViewControllerTests: QuickSpec {
  override func spec() {
    let contextProvider = FakeContextProvider()
    var subject: AddMealViewController!
    var presenter: MockAddMealPresenting!

    beforeEach {
      subject = AddMealFactory(contextProvider: contextProvider).instantiate()
      presenter = MockAddMealPresenting()
      subject.presenter = presenter

      subject.setAsRootViewController()
    }

    describe("initial state") {
      beforeEach {
        subject.viewDidAppear(false)
      }
      it("keyboard is open and focused on meal name") {
        expect(subject.mealNameField.isFirstResponder).to(beTrue())
      }
      it("save is disabled") {
        expect(subject.saveButton.isEnabled).to(beFalse())
      }
    }

    describe("meal name field changes") {
      beforeEach {
        subject.mealNameField.text = "blah"
        subject.mealNameChanged()
      }
      it("updates the presenter with new meal name") {
        expect(presenter.newMealName).to(equal("blah"))
      }
    }

    describe("tap on save") {
      beforeEach {
        subject.saveTapped(UIBarButtonItem())
      }
      it("passes it on to the presenter") {
        expect(presenter.saveTappedCalled).to(beTrue())
      }
    }

    describe("tap on cancel") {
      beforeEach {
        subject.cancelTapped(UIBarButtonItem())
      }
      it("passes it on to the presenter") {
        expect(presenter.cancelTappedCalled).to(beTrue())
      }
    }

    describe("save button state") {
      context("set to enabled") {
        beforeEach {
          subject.setSaveButtonState(enabled: true)
        }
        it("enables the button") {
          expect(subject.saveButton.isEnabled).to(beTrue())
        }
      }
      context("set to disabled") {
        beforeEach {
          subject.setSaveButtonState(enabled: false)
        }
        it("disables the button") {
          expect(subject.saveButton.isEnabled).to(beFalse())
        }
      }
    }

    describe("duplicate meal alert") {
      beforeEach {
        subject.showDuplicateMealAlert()
      }
      it("shows an alert") {
        expect(subject.presentedViewController).to(beAKindOf(UIAlertController.self))
        expect(subject.presentedViewController?.view).toNot(beNil())
      }
      describe("alert configuration") {
        var alert: UIAlertController?
        beforeEach {
          alert = subject.presentedViewController as? UIAlertController
        }
        it("has the correct title") {
          expect(alert?.title).to(equal("Duplicate Meal"))
        }
        it("has the correct text") {
          expect(alert?.message).to(equal("A meal with the same name already exists."))
        }
        it("has one action which is OK") {
          expect(alert?.actions.count) == 1
          expect(alert?.actions.first?.title).to(equal("OK"))
        }
      }
    }

    describe("entering data and pressing return") {
      var result = false
      var textField: UITextField!
      context("ingredient field") {
        beforeEach {
          textField = subject.ingredientField
          textField.text = "purple salt"
          result = subject.textFieldShouldReturn(textField)
        }
        it("returns true") {
          expect(result).to(beTrue())
        }
        it("adds the ingredient") {
          expect(presenter.addedIngredient).to(equal("purple salt"))
        }
        it("resets the field") {
          expect(textField.text).to(beEmpty())
        }
      }
      context("meal name field") {
        beforeEach {
          textField = subject.mealNameField
          textField.text = "dharma canned food"
          result = subject.textFieldShouldReturn(textField)
        }
        it("returns true") {
          expect(result).to(beTrue())
        }
        it("does not add an ingredient") {
          expect(presenter.addedIngredient).to(beNil())
        }
        it("does not reset the field") {
          expect(textField.text).toNot(beEmpty())
        }
      }
    }

    describe("add ingredient button pressed") {
      beforeEach {
        subject.ingredientField.text = "purple salt"
        subject.addIngredientTapped()
      }
      it("adds the ingredient") {
        expect(presenter.addedIngredient).to(equal("purple salt"))
      }
      it("resets the field") {
        expect(subject.ingredientField.text).to(beEmpty())
      }
    }

    describe("ingredients collection") {
      beforeEach {
        presenter.ingredients = ["purple salt", "blue saly"]
      }
      it("has the correct number of items") {
        let count = subject.collectionView(subject.ingredientsCollection, numberOfItemsInSection: 0)
        expect(count) == 2
      }
      it("creates the ingredient cell with the correct ingredients") {
        for index in 0..<presenter.ingredients.count {
          let indexPath = IndexPath(row: index, section: 0)
          let cell = subject.collectionView(subject.ingredientsCollection, cellForItemAt: indexPath)

          expect((cell as? AddIngredientCell)?.ingredientName.text).to(equal(presenter.ingredients[index]))
        }
      }
      it("gets the correct size for ingredient cell") {
        let size = "purple salt".size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)])
        let correctSize = CGSize(width: ceil(size.width) + 8, height: ceil(size.height) + 8)

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = subject.collectionView(subject.ingredientsCollection, cellForItemAt: indexPath)

        expect(cell.frame.size).to(equal(correctSize))
      }
      it("throws a fatal error if cell is incorrect") {
        let indexPath = IndexPath(row: 0, section: 0)
        expect { () -> Void in _ = subject.collectionView(MockCollectionView(), cellForItemAt: indexPath) }
          .to(throwAssertion())
      }

      describe("reloading ingredients") {
        let mockIngredientsCollection = MockCollectionView()
        beforeEach {
          subject.ingredientsCollection = mockIngredientsCollection
          subject.reloadIngredients()
        }
        it("reloads the ingredients collection") {
          expect(mockIngredientsCollection.reloadDataCalled).to(beTrue())
        }
      }
    }
  }
}

// MARK: Test doubles
extension AddMealViewControllerTests {
  class MockAddMealPresenting: AddMealPresenting {
    private(set) var newMealName: String?
    func mealNameChanged(to newMealName: String) {
      self.newMealName = newMealName
    }

    private(set) var saveTappedCalled = false
    func saveTapped() {
      saveTappedCalled = true
    }

    private(set) var cancelTappedCalled = false
    func cancelTapped() {
      cancelTappedCalled = true
    }

    private(set) var addedIngredient: Ingredient?
    func ingredientAdded(_ ingredient: Ingredient) {
      addedIngredient = ingredient
    }

    var ingredients = [Ingredient]()
  }

  class MockCollectionView: UICollectionView {
    init() {
      super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                 collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func dequeueReusableCell(withReuseIdentifier identifier: String,
                                      for indexPath: IndexPath) -> UICollectionViewCell {
      return UICollectionViewCell()
    }

    private(set) var reloadDataCalled = false
    override func reloadData() {
      reloadDataCalled = true
    }
  }
}
