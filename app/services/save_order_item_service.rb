class SaveOrderItemService
  LUNCH_CODE = "#happylunch".freeze

  def self.call(info)
    return unless order = Order.today.last

    message = info["text"].gsub!(LUNCH_CODE,"").strip
    numbers = message.split(", ")

    Dish.where(item_number: numbers).each do |dish|
      order_item = OrderItem.find_or_initialize_by(order_id: order.id, username: info["user_name"])
      order_item.dish = dish
      order_item.save
    end
  end
end
