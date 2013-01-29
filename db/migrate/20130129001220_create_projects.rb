class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :license
      t.string :organization
      t.boolean :accepts_requests
      t.timestamps
    end
  end
end
