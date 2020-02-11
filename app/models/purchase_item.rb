class PurchaseItem < ApplicationRecord
    belongs_to :list
    belongs_to :item

    attr_reader :included
    
    def grocery_category
        self.item.grocery_category
    end

    def grocery_category_id
        self.item.grocery_category_id
    end

    
    
end
