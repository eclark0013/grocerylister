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

items = [
    "broccoli",
    "pasta",
    "chicken",
    "garlic",
    "extra virgin olive oil",
    "pecorino romano cheese",
    "salt",
    "pepper",
    "shredded cheddar cheese",
    "eggs",
    "milk",
    "red bell pepper"
]

items.each do |item|
    Item.create(name: item)
end

r1 = Recipe.create(name: "Easy one-pot pasta", user: u1)
r2 = Recipe.create(name: "Omelette with broccoli and red pepper", user: u2)

# adding items to "Easy one-pot pasta"
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "broccoli").id)
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "pasta").id)
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "chicken").id)
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "garlic").id)
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "extra virgin olive oil").id)
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "pecorino romano cheese").id)
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "salt").id)
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "pepper").id)
    RecipeItem.create(recipe_id: r1.id, item_id: Item.find_by(name: "shredded cheddar cheese").id)

# adding items to "Omelette with broccoli and red pepper"
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "eggs").id)
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "shredded cheddar cheese").id)
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "milk").id)
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "salt").id)
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "broccoli").id)
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "red bell pepper").id)
    RecipeItem.create(recipe_id: r2.id, item_id: Item.find_by(name: "pepper").id)