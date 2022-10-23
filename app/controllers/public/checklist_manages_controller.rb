class Public::ChecklistManagesController < ApplicationController


  def update_all_checklist_manage
    @camp = Camp.find(params[:id])
    #campのis_activeがtrueのものをchecklist_idを指定し配列で取得
    active_checklist_ids = @camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq #[2,3,6,9]
    #さらにchecklistモデルからactive_checklist_idsを探す
    @checklists = Checklist.where(id: active_checklist_ids)
    checklist_list = checklists.split(/[[:blank:]]+/)
    #登録したいパラメーターと登録ずみのパラメーターの差分を抽出
    new_checklist_manages = checklist_list - active_checklist_ids

    new_checklist_manages.each do |new|
      new_checklist = ChecklistManage.find_or_create_by(is_active: new)
    end

    old_checklist_manages =   active_checklist_ids - checklist_list
    old_checklists.each do |old|
      self.checklist.delete ChecklistManage.find_by(is_active: old)
    end
    
    checklistmanage

  end

end
