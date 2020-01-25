class RecipeItem < ApplicationRecord
    belongs_to :recipe
    belongs_to :item

    def item_name
        if self.item
            self.item.name
        else
            nil
        end
    end

    def item_name=(name)
        if self.item
            self.item.name=(name)
            self.item.save
        else
            self.create_item(name: name)
        end
    end
end
