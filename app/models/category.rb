class Category < ApplicationRecord
    
    has_many :checklists, dependent: :destroy
end
