class CreateBuyers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers do |t|
      t.belongs_to :house, foreign_key: true
      t.belongs_to :hunter, foreign_key: true

      t.timestamps
    end
  end
end
