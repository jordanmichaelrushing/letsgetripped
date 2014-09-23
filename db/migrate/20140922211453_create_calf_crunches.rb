class CreateCalfCrunches < ActiveRecord::Migration
  def change
    create_table :calf_crunches do |t|
      t.string :set_type, default: "Crunch"
      t.integer :set, default: 0
      t.integer :reps, default: 0
      t.integer :day_id
      t.integer :user_id

      t.timestamps
    end
  end
end
