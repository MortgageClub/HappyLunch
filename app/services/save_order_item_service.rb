class SaveOrderItemService
  LUNCH_CODE = "#happylunch".freeze

  def self.call(info)
    return unless today_order

    message = info["text"].gsub!(LUNCH_CODE, "").strip
    numbers = message.split(", ")

    Dish.where(item_number: numbers).each do |dish|
      order_item = OrderItem.find_or_initialize_by(
        order: today_order, username: info["user_name"], dish: dish
      )
      order_item.save
    end
  end

  private

  def find_or_update_order_item(dish)
    order_item = OrderItem.find_or_initialize_by(order: today_order, username: info["user_name"])
    order_item.dish = dish
    order_item.save
  end

  def self.today_order
    @today_order ||= Order.today.last
  end
end
