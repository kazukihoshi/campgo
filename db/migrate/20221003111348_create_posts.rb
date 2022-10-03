class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :user_id, null: false
      t.text :post, null: false
      t.string :camp_site, null: false
      t.string :area, null: false
      t.string :prefecture, null: false
      t.string :location, null: false
      t.string :scene, null: false
      t.string :facility_type, null: 
      t.timestamps
    end
  end
end
