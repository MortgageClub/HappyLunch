require 'nokogiri'
require 'open-uri'

class GetMenuService
  def self.call
    item_number = 0
    dishes = []
    doc = get_html('http://giachanhcamtuyet.com.vn/index.php?m=dat-tiec&id=12&t=orders&s=1')

    doc.css("div.list_item").each do |item|
      name_element = get_element(item, "div.name")
      price_element = get_element(item, "div.price input")

      next unless valid_dish?(price_element["value"].to_f)

      dishes << {name: name_element.text, price: price_element["value"].to_f, number: item_number += 1}
    end
    dishes
  end

  def self.get_html(url)
    Nokogiri::HTML(open(url))
  end

  def self.get_element(html, selector)
    html.at_css(selector)
  end

  def self.valid_dish?(price)
    price >= 20_000 && price <= 50_000
  end
end
