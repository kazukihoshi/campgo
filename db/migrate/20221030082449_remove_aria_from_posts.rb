class RemoveAriaFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :area, :string
    remove_column :posts, :prefecture, :string
    remove_column :posts, :location, :string
    remove_column :posts, :scene, :string
    remove_column :posts, :facility_type, :string
  end
end
