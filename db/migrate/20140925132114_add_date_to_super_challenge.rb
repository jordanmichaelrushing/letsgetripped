class AddDateToSuperChallenge < ActiveRecord::Migration
  def change
    add_column :super_challenges, :date, :datetime
  end
end
