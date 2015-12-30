require 'capybara'
require 'capybara/poltergeist'

class OrderLunchService
  include Capybara::DSL

  attr_accessor :crawler, :result

  def initialize
    @crawler = set_up_crawler
    @result = false
  end

  def call
    go_to_gcct
    fill_order_item
    fill_contact_info
    skip_captcha
    submit_order
    sleep(1)
    check_status
    close_crawler
    result
  end

  private

  def go_to_gcct
    crawler.visit("http://giachanhcamtuyet.com.vn/index.php?m=dat-tiec&id=12&t=orders&s=1")
  end

  def fill_order_item
    Order.today.first.order_items.each do |item|
      item_element = crawler.all(".name", text: item.dish.name)[0]
      parent = item_element.find(:xpath, '..')
      assign_quantity_item(parent)
      select_item(parent)
    end
  end

  def fill_contact_info
    crawler.find("#fullname").set("Diệu Linh")
    crawler.find("#address").set("93bis Nguyễn Văn Thủ, P. Đa Kao, Q.1")
    crawler.find("#tel").set("0986088803")
    crawler.find("#email").set("linh@mortgageclub.co")
  end

  def skip_captcha
    crawler.find("#captcha").set("6BA2C")
    crawler.find("#captcha_sid").set("911db58a17dad229cdb9f469dc4cf616")
  end

  def assign_quantity_item(item)
    quantity_item = item.find("div.quantity input")
    quantity_item.set(quantity_item.value.to_i + 1)
  end

  def select_item(item)
    click_item = item.find("div.request a")
    click_item.click if click_item.text == "Chọn"
  end

  def submit_order
    crawler.find("input[type=submit]").click
  end

  def set_up_crawler
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, js_errors: false, timeout: 60, inspector: true, phantomjs_options: ['--ignore-ssl-errors=yes', '--local-to-remote-url-access=yes'])
    end
    Capybara.ignore_hidden_elements = false
    Capybara.default_max_wait_time = 60
    Capybara::Session.new(:poltergeist)
    # Capybara::Session.new(:selenium)
  end

  def close_crawler
    crawler.driver.quit
  end

  # rubocop:disable LineLength
  def check_status
    success_message = crawler.all(".report", text: "Cám ơn quý khách đã quan tâm đến dịch vụ của chúng tôi! Yêu cầu của quý khách sẽ được phản hồi trong thời gian sớm nhất.")[0]
    @result = success_message ? true : false
  end
  # rubocop:enable LineLength
end
