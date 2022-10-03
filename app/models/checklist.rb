class Checklist < ApplicationRecord
    
    has_many :checklist_manages, dependent: :destory
    
    belongs_to :user
    belongs_to :category

end
