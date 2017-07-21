class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :about, :string
    add_column :users, :image, :string
    add_column :users, :nickname, :string
    add_column :users, :isAdmin, :boolean, default: false
  end
end
