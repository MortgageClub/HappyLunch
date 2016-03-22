class SaveOrderItemService
  attr_reader :info, :saved_order_items

  LUNCH_CODE = "#happylunch".freeze

  def initialize(info)
    @info = info
    @saved_order_items = []
  end

  # rubocop:disable MethodLength
  def call
    success = true
    return false unless today_order
    destroy_old_orders(info["user_name"])
    begin
      Dish.where(item_number: item_numbers).each do |dish|
        order_item = OrderItem.new(order: today_order, username: info["user_name"], dish: dish)
        @saved_order_items << order_item if order_item.save
      end
    rescue ActiveRecord::RecordInvalid
      success = false
    end
    success
  end
  # rubocop:enable MethodLength

  def today_order
    Order.today.last
  end

  def destroy_old_orders(username)
    OrderItem.where(order: today_order, username: username).destroy_all
  end

  def item_numbers
    message = info["text"].gsub!(LUNCH_CODE, "").strip
    message.split(", ")
  end
end
