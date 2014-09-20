class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.datetime :date
      t.string :img_url
      t.integer :user_id

      t.timestamps
    end
  end
end
