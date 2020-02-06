class PurchaseItem < ApplicationRecord
    belongs_to :list
    belongs_to :item

    def grocery_category
        self.item.grocery_category
    end

    def grocery_category_id
        self.item.grocery_category_id
    end

    def included
    end
    
end
