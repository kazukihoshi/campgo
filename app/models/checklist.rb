class Checklist < ApplicationRecord
    
    #dependent: :destoryではArgumentErrorになったため変更
    has_many :checklist_manages, dependent: :delete_all
    
    belongs_to :user
    belongs_to :category

end
