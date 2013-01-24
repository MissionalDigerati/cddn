class CreateProgrammings < ActiveRecord::Migration
  def change
    create_table :programmings do |t|
      t.integer :programming_language_id
      t.belongs_to :programmable, polymorphic: true
      t.timestamps
    end
  end
end
