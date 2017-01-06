// MealPlan by Chirag Gupta

protocol MealsProvider {
    func getMeals() -> [Meal]
}

struct MealsModel: MealsProvider {
    func getMeals() -> [Meal] {
        return [
            Meal(title: "Butter chicken and rice"),
            Meal(title: "Quesadilla"),
            Meal(title: "Pizza"),
            Meal(title: "Rajma and rice"),
            Meal(title: "Momos"),
            Meal(title: "Broccoli pasta"),
            Meal(title: "Aloo paratha")
        ]
    }
}
