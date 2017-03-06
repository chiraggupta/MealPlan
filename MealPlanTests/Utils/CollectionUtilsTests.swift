// MealPlan by Chirag Gupta

import XCTest
@testable import MealPlan

class CollectionUtilsTests: XCTestCase {
  func testRemovingDuplicates() {
    let list = [
      "eindhoven",
      "amsterdam",
      "delhi",
      "amsterdam",
      "eindhoven",
      "barcelona",
      "eindhoven",
      "prague",
      "eindhoven"
    ]
    let uniqueCities = ["eindhoven", "amsterdam", "delhi", "barcelona", "prague"]
    XCTAssertEqual(uniqueCities, list.removingDuplicates())
  }
}
