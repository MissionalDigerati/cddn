class AddProjectApprovedToUsersAndProjects < ActiveRecord::Migration
  def self.up
    add_column :users, :project_approved, :boolean, :default => false
    add_column :projects, :approved_project, :boolean, :default => false
  end
  
  def self.down
    remove_column :users, :project_approved
    remove_column :projects, :approved_project
  end
end
