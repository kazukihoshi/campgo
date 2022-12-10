class Public::ChecklistManagesController < ApplicationController
  before_action :authenticate_user!
  def update_all_checklist_manage
    @camp = Camp.find(params[:id])

    checklistmanage

  end

end
