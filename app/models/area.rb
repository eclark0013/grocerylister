class Area < ApplicationRecord
    validates :name, presence: true
    belongs_to :store
end
