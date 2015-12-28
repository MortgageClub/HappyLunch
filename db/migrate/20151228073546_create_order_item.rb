class CreateOrderItem < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :dish, index: true, foreign_key: true
    end
  end
end
