require 'nokogiri'
require 'open-uri'

class GetMenuService
  def self.call
    doc = get_html('http://giachanhcamtuyet.com.vn/index.php?m=dat-tiec&id=12&t=orders&s=1')
    count = 1

    Order.create(order_date: Time.zone.now) unless Order.today
    Dish.update_all(item_number: nil)

    get_elements(doc, "div.list_item").each do |item|
      name_element = get_element(item, "div.name")
      price_element = get_element(item, "div.price input")

      name = name_element.text
      price = price_element["value"].to_f

      if valid_dish?(price)
        dish = Dish.find_or_initialize_by(name: name)
        dish.update(price: price, item_number: count)
        count += 1
      end
    end
  end

  def self.get_html(url)
    Nokogiri::HTML(open(url))
  end

  def self.get_element(html, selector)
    html.at_css(selector)
  end

  def self.get_elements(html, selector)
    html.css(selector)
  end

  def self.valid_dish?(price)
    price >= 20000 && price <= 50000
  end
end
