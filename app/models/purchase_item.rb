class PurchaseItem < ApplicationRecord
    belongs_to :list
    belongs_to :item

    # created after a user goes over the draft of a list and then 
    # creates purchase items for each unique item and adds them
    # to said list

    def name
        if self.item
            self.item.name
        else
            nil
        end
    end

    def name=(name)
        if self.item
            self.item.name=(name)
            self.item.save
        else
            self.create_item(name: name)
        end
    end
    
end
