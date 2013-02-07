class RemoveTeamApprovedFromMemberships < ActiveRecord::Migration
  def up
    remove_column :memberships, :team_approved
  end

  def down
    add_column :memberships, :team_approved, :boolean, :default => false
  end
end
