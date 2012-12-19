class AddUserInfoToUsersTable < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :church, :string
    add_column :users, :bio, :text
    add_column :users, :city_province, :string
    add_column :users, :state_id, :integer
    add_column :users, :country_id, :integer
    add_column :users, :primary_role, :string
  end
  
  def down                           
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :nickname
    remove_column :users, :church
    remove_column :users, :bio
    remove_column :users, :city_province
    remove_column :users, :state_id
    remove_column :users, :country_id
    remove_column :users, :primary_role
  end
end
