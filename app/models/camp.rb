class Camp < ApplicationRecord

    has_many :checklist_manages, dependent: :destroy

    has_many :checklists, through: :checklist_manages
    belongs_to :user
end
