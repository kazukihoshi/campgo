class ChangeUserIdNull < ActiveRecord::Migration[6.1]
  def change
    
    change_column_null :checklists, :user_id, true
    
  end
end
