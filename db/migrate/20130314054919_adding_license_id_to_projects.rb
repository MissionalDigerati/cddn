class AddingLicenseIdToProjects < ActiveRecord::Migration
  def up
  	add_column :projects, :license_id, :integer
    remove_column :projects, :license
  end

  def down
  	add_column :projects, :license, :string
  	remove_column :projects, :license_id
  end
end
