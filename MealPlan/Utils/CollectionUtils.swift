// MealPlan by Chirag Gupta

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var result = [Element]()
        var alreadyAdded = Set<Element>()

        for item in self {
            if !alreadyAdded.contains(item) {
                alreadyAdded.insert(item)
                result.append(item)
            }
        }
        return result
    }
}
