class Public::ChecklistManagesController < ApplicationController


  def update_all_checklist_manage
    @camp = Camp.find(params[:id])

    checklistmanage

  end

end
