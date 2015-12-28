class SaveOrderItemService
  LUNCH_CODE = "#happylunch".freeze

  def self.call(info)
    return unless order = Order.today.last

    message = info["text"].gsub!(LUNCH_CODE,"").strip
    numbers = message.split(", ")

    Dish.where(item_number: numbers).each do |dish|
      OrderItem.create(dish: dish, order: order, username: info["user_name"])
    end
  end
end
