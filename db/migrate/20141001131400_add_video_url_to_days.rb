class AddVideoUrlToDays < ActiveRecord::Migration
  def change
    add_column :days, :video_url, :string
  end
end
