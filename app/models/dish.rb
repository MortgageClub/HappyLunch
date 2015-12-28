class Dish < ActiveRecord::Base
  validates :title, presence: true
  has_many :order_items
end