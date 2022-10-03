class ChecklistManage < ApplicationRecord
    
    belongs_to :camp
    belongs_to :user
    belongs_to :checklist
    
end
