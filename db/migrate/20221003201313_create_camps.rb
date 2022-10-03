class CreateCamps < ActiveRecord::Migration[6.1]
  def change
    create_table :camps do |t|

      t.integer :user_id, null: false
      t.date :schedule, null: false
      t.string :camp_site, null: false
      t.integer :number_of_people, null: false
      t.timestamps
    end
  end
end
