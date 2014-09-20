class CreateSuperChallenge < ActiveRecord::Migration
  def change
    create_table :super_challenges do |t|
      t.string :notes
      t.float :push_ups
      t.float :pull_ups
      t.float :duration
      t.float :distance
      t.integer :times_walked
      t.integer :day_id
      t.integer :user_id

      t.timestamps
    end
  end
end
