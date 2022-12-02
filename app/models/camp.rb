class Camp < ApplicationRecord

    has_many :checklist_manages, dependent: :destroy

    has_many :checklists, through: :checklist_manages
    belongs_to :user

    validates :schedule, presence: true
    validates :camp_site, presence: true
    validates :number_of_people, presence: true

end
