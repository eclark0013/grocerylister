# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ 'Star Wars' }, { 'Lord of the Rings' }])
#   Character.create('Luke', movie: movies.first)
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

User.create(name: "eric", password: "clark")

items = [
    "broccoli",
    "pasta",
    "chicken",
    "garlic",
    "extra virgin olive oil",
    "pecorino romano cheese",
    "salt",
    "pepper",
]

items.each do |item|
    Item.create(name: item)
end

Recipe.create(name: "Easy one-pot pasta")

RecipeItem.create(recipe_id: Recipe.find_by(name: "Easy one-pot pasta").id, item_id: Item.find_by(name: "broccoli").id)