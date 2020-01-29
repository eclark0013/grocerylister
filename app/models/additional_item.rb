class AdditionalItem < ApplicationRecord
    belongs_to :list
    belongs_to :item

    def name
        if self.item
            self.item.name
        else
            nil
        end
    end

end
