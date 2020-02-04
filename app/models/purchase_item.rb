class PurchaseItem < ApplicationRecord
    belongs_to :list
    belongs_to :item

    def grocery_category
        self.item.grocery_category
    end
    
end
