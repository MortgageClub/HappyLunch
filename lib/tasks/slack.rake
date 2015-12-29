namespace :slack do
  desc "Notify Lunch Menu"

  task :get_menu do
    puts "Start getting menu..."
    GetMenuService.call
    puts "Finish getting menu..."
  end

  task :order_lunch do
    puts "Start ordering lunch..."
    OrderLunchService.new.call
    puts "Finish ordering lunch..."
  end

  task :notify_lunch_menu => :environment do
    SendMessageToSlackService.post_lunch_menu_to_slack_lunch("#lunch")
  end

  task :notify_user_order => :environment do
    Order.notify_users
  end
end
