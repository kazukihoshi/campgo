class Camp < ApplicationRecord

    has_many :checklist_manages, dependent: :destroy

    has_many :checklists, through: :checklist_manages
    belongs_to :user

    # accepts_nested_attributes_for :checklist_manages, allow_destroy: true

    validates :schedule, presence: true
    validates :camp_site, presence: true
    validates :number_of_people, presence: true


    # def save_checklists
    #   #元々チェックされているもののchecklist_idを取得
    #   active_checklist_ids = camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq #[2,3,6,9]
    #   current_checklists = self.checklists.pluck('checklist_id')
    #   old_checklists = current_checklists -  active_checklist_ids
    #   new_checklists =  active_checklist_ids - current_checklists
    #   old_checklists.each do |old|
    #     self.checklists.delete ChecklistManage.find_by(checklist_id: checklist, camp_id: camp.id, user_id: current_user.id)
    #   end
    #   new_checklists.each do |new|
    #     new_checklist_manage = ChecklistManage.find_or_create_by(checklist_id: checklist, camp_id: camp.id, user_id: current_user.id)
    #   end
    #   self.checklists << new_checklist_manage
    # end
end
