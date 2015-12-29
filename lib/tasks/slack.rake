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
    puts "Notifying lunch menu job is running"
    SendMessageToSlackService.call("#lunch")
    puts "Notifying lunch is running on background"
  end
end
