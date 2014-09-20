class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.string :notes
      t.float :protein
      t.float :carbs
      t.float :fats
      t.float :sugar
      t.float :sodium
      t.float :saturated_fats
      t.float :cholesterol
      t.float :fiber
      t.integer :meal_number
      t.integer :day_id
      t.integer :user_id

      t.timestamps
    end
  end
end
