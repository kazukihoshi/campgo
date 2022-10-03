class Camp < ApplicationRecord
    
    has_many :checklist_manages, dependent: :destroy
    
    belongs_to :user
end
