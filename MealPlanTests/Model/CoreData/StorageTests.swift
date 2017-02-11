// MealPlan by Chirag Gupta

import Quick
import Nimble
import CoreData
@testable import MealPlan

class StorageTests: QuickSpec {
    override func spec() {
        var testContext: MockContext!
        beforeEach {
            testContext = MockContext(concurrencyType: .mainQueueConcurrencyType)
        }

        describe("fetching from storage") {
            let request: NSFetchRequest<NSManagedObject> = NSFetchRequest()
            it("executes request on context") {
                _ = Storage.fetch(request, context: testContext)

                expect(testContext.fetchedRequest).to(equal(request))
            }

            it("returns entities") {
                let result = Storage.fetch(request, context: testContext)

                expect(result).to(equal(testContext.fetchResult))
            }

            context("error while fetching") {
                beforeEach {
                    testContext.throwOnFetch = true
                }
                it("it throws an assertion") {
                    expect { () -> Void in _ = Storage.fetch(request, context: testContext) }.to(throwAssertion())
                }
            }
        }

        describe("saving context") {
            context("when there are no changes") {
                beforeEach {
                    testContext.changes = false
                }
                it("it doesn't save") {
                    Storage.saveContext(testContext)

                    expect(testContext.saveCalled).to(beFalse())
                }
            }
            context("when there are changes") {
                beforeEach {
                    testContext.changes = true
                }
                it("it saves") {
                    Storage.saveContext(testContext)

                    expect(testContext.saveCalled).to(beTrue())
                }

                describe("error while saving") {
                    beforeEach {
                        testContext.throwOnSave = true
                    }
                    it("throws an assertion") {
                        expect { () -> Void in Storage.saveContext(testContext) }.to(throwAssertion())
                    }
                }
            }
        }
    }

    enum TestError: Error {
        case somethingBroke
    }

    class MockContext: NSManagedObjectContext {
        var fetchedRequest: NSFetchRequest<NSFetchRequestResult>?
        var saveCalled = false
        var changes = false
        var throwOnSave = false
        var throwOnFetch = false
        let fetchResult = [NSManagedObject(), NSManagedObject()]

        override var hasChanges: Bool {
            return changes
        }

        override func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any] {
            fetchedRequest = request

            if throwOnFetch {
                throw TestError.somethingBroke
            }

            return fetchResult
        }

        override func save() throws {
            saveCalled = true

            if throwOnSave {
                throw TestError.somethingBroke
            }
        }
    }
}
