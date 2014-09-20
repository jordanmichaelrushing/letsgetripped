class CreateCardio < ActiveRecord::Migration
  def change
    create_table :cardios do |t|
      t.string :name
      t.string :notes
      t.float :duration
      t.float :distance
      t.float :sixty_percent_speed
      t.float :eighty_percent_speed
      t.float :ninety_percent_speed
      t.float :one_hundred_percent_speed
      t.integer :times_walked
      t.integer :day_id
      t.integer :user_id

      t.timestamps
    end
  end
end
