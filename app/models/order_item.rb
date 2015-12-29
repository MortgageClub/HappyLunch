class OrderItem < ActiveRecord::Base
  belongs_to :dish
  belongs_to :order

  validates :dish_id, presence: true
  validates :order_id, presence: true
  validates :username, presence: true
end