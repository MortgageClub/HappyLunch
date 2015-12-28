class AddItemNumberToDish < ActiveRecord::Migration
  def change
    add_column :dishes, :item_number, :integer
  end
end
