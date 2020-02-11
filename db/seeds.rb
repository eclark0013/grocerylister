# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ 'Star Wars' }, { 'Lord of the Rings' }])
#   Character.create('Luke', movie: movies.first)
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

u1 = User.create(name: "eric", password: "clark")
u2 = User.create(name: "joey", password: "clark")

grocery_categories = [
    "refrigerated produce",
    "other produce",
    "frozen",
    "dairy",
    "meats & cheeses",
    "dry goods",
    "snacks",
    "beverages",
    "misc"
]

grocery_categories.each do |category|
    GroceryCategory.create(name: category)
end

items = [
    ["broccoli", "refrigerated produce"],
    ["pasta", "dry goods"],
    ["chicken", "frozen"],
    ["garlic", "dry goods"],
    ["extra virgin olive oil", "dry goods"],
    ["pecorino romano cheese", "meats & cheeses"],
    ["salt", "dry goods"],
    ["pepper", "dry goods"],
    ["shredded cheddar cheese", "meats & cheeses"],
    ["eggs", "dairy"],
    ["milk", "dairy"],
    ["red bell pepper", "other produce"],
    ["butter", "dairy"]
]

items.each do |item|
    Item.create(name: item[0], grocery_category_id: GroceryCategory.find_by(name: item[1]).id)
end

r1 = Recipe.create(name: "Easy one-pot pasta", user: u1, directions: "Cook the pasta with the broccoli. Cook the chicken separately and cut into small pieces. After pasta is in strainer, use pot to cook garlic in evoo. Then add back in the pasta with chicken and cheese.")
r2 = Recipe.create(name: "Omelette with broccoli and red pepper", user: u2, directions: "Cook the broccoli and red peppers in pan with butter. Beat eggs, milk, salt, and pepper together. Add eggs and milk into pan. When finished top with cheese.")
r3 = Recipe.create(name: "PB & J", user: u2, directions: "Put together the peanut butter and jelly to make a sandwich.")

# adding items to "Easy one-pot pasta"
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "broccoli").id, quantity: "6 cups")
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "pasta").id, quantity: "1 pound")
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "chicken").id, quantity: "1 pound")
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "garlic").id, quantity: "5 cloves")
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "extra virgin olive oil").id, quantity: "2 tablespoons")
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "pecorino romano cheese").id, quantity: "1/4 cup")
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "salt").id, quantity: "1/2 teaspoon")
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "pepper").id, quantity: "to taste")

# adding items to "Omelette with broccoli and red pepper"
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "butter").id, quantity: "1 tablespoon")
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "eggs").id, quantity: "3")
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "shredded cheddar cheese").id, quantity: "1/4 cup")
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "milk").id, quantity: "2 tablespoons")
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "salt").id, quantity: "1/4 teaspoon")
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "broccoli").id, quantity: "1/2 cup")
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "red bell pepper").id, quantity: "1/4 cup")
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "pepper").id, quantity: "to taste")

# adding items to "PB & J"
    RecipeItem.create(recipe_id: r3.id, item_id: Item.find_or_create_by(name: "peanut butter").id, quantity: "1 tablespoon")
    RecipeItem.create(recipe_id: r3.id, item_id: Item.find_or_create_by(name: "jelly").id, quantity: "1 tablespoon")
    RecipeItem.create(recipe_id: r3.id, item_id: Item.find_or_create_by(name: "bread").id, quantity: "2 slices")


# make a list
    l1 = List.create(user: u1, name: "The best grocery trip ever")

# add recipes to l1
    l1.add_recipe(r1)
    l1.add_recipe(r3)

# add additional items to l1
    l1.add_additional_item("oranges", "3")
    l1.add_additional_item("pears", "1 bag")
    l1.add_additional_item("ritz crackers", "2 boxes")
    l1.add_additional_item("peanut butter", "1 container")
    l1.add_additional_item("brie", "1/4 pound")

# make a list 2
l2 = List.create(user: u1, name: "Another list")

# add recipes to l1
    l2.add_recipe(r2)
    l2.add_recipe(r3)

# add additional items to l1
    l2.add_additional_item("peas", "1 bag")
    l2.add_additional_item("broccoli", "1 bag")
    l2.add_additional_item("chocolate bar", "1")
    l2.add_additional_item("chopped onion", "1 cup")
    l2.add_additional_item("romaine lettuce", "1 head")