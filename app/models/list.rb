class List < ApplicationRecord 
    validates :name, presence: true

    has_many :additional_items
    # has_many :items, through: :additional_items

    has_many :list_recipes
    has_many :recipes, through: :list_recipes
    has_many :recipe_items, through: :recipes
    # has_many :items, through: :recipe_items

    has_many :list_items

    has_many :purchase_items
    has_many :items, through: :purchase_items

    belongs_to :user

    accepts_nested_attributes_for :recipes
    accepts_nested_attributes_for :additional_items
    accepts_nested_attributes_for :purchase_items

    def set_name_and_user(current_user,list_params)
        list_name = list_params[:name]
        if list_name == ""
            list_name = Time.now.strftime("List created %m/%d/%Y at %I:%M%p")
        end
        self.update(
            name: list_name,
            user_id: current_user.id
            )
    end
    # the view page should contain a note about how this is what it will do if it is left blank
end
