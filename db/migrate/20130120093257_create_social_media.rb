class CreateSocialMedia < ActiveRecord::Migration
  def change
    create_table :social_media do |t|
      t.string :service
      t.timestamps
    end
  end
end
