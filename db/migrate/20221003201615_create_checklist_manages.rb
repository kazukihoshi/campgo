class CreateChecklistManages < ActiveRecord::Migration[6.1]
  def change
    create_table :checklist_manages do |t|

      t.integer :camp_id, null: false
      t.integer :user_id, null: false
      t.integer :checklist_id, null: false
      t.boolean :is_active, null: false, default: false
      t.timestamps
    end
  end
end
