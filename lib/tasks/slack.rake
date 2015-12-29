namespace :slack do
  desc "Notify Lunch Menu"
  task :notify_lunch_menu => :environment do
    puts "Notifying lunch menu job is running"
    SendMessageToSlackService.post_lunch_menu_to_slack_lunch("#lunch")
    puts "Notifying lunch is running on background"
  end
  task :notify_user_order => :environment do
    puts "Notifying user has not ordered lunch job is running"
    Order.notify_users
    puts "Notifying user has not ordered lunch job is finished"
  end
end