class Public::ChecklistManagesController < ApplicationController


  def update_camp_checklist_manage
    #tag_list = tags.split(/[[:blank:]]+/)
    active_checklist_ids = @camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq #[2,3,6,9]
    @checklists = Checklist.where(id: active_checklist_ids)
    checklist_list = checklists.split(/[[:blank:]]+/)
    new_checklist_manages = checklist_list - current_user.checklist.id
  
  end

end
