class AddImageToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :images, :string
  end
end
