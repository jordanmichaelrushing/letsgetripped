class CreatePushups < ActiveRecord::Migration
  def change
    create_table :pushups do |t|
      t.integer :set_one_reps
      t.integer :set_two_reps
      t.string :set_three_reps
      t.integer :day_id
      t.integer :user_id

      t.timestamps
    end
  end
end
