class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :notes
      t.string :name
      t.string :img_url
      t.float :set_one_weight
      t.float :set_two_weight
      t.float :set_three_weight
      t.float :set_four_weight
      t.integer :amrap_quantity
      t.integer :day_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
