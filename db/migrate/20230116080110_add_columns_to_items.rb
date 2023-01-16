class AddColumnsToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :address, :string
    add_column :items, :latitude, :float
    add_column :items, :longitude, :float
    add_column :items, :customer_id, :integer
  end
end
