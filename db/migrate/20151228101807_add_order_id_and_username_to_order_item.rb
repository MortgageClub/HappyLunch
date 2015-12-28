class AddOrderIdAndUsernameToOrderItem < ActiveRecord::Migration
  def change
    add_reference :order_items, :order, index: true, foreign_key: true
    add_column :order_items, :username, :string
  end
end
