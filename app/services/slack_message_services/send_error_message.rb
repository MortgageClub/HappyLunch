module SlackMessageServices
  class SendErrorMessage < Base
    def self.call
      content = "<!here> Sorry, We cannot order lunch. There are something wrong with waiter."
      send_message(content)
    end
  end
end
