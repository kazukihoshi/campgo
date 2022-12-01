class Category < ApplicationRecord

    has_many :checklists, dependent: :destroy

    validates :category_name, presence: true

end
