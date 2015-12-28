class Dish < ActiveRecord::Base
  validates :name, presence: true
  has_many :order_items
end