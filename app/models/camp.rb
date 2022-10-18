class Camp < ApplicationRecord

    has_many :checklist_manages, dependent: :destroy

    has_many :checklists, through: :checklist_manages
    belongs_to :user
    accepts_nested_attributes_for :checklist_manages, allow_destroy: true
end
