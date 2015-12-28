class Dish < ActiveRecord::Base
  validates :name, presence: true
  has_many :order_items

  scope :today, -> { where("item_number != nil") }
end