class AddTeamApprovedToMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :team_approved, :boolean, :default => false
  end
  
  def self.down
    remove_column :memberships, :team_approved
  end
end
