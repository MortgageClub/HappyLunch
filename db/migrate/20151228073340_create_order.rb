class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.string :description
    end
  end
end
