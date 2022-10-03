class CreateChecklists < ActiveRecord::Migration[6.1]
  def change
    create_table :checklists do |t|

      t.integer :category_id, null: false
      t.integer :user_id, null: false
      t.string :checklist_name, null: false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
