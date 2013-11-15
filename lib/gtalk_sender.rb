require 'easy-gtalk-bot'

class GTalkSender
  def self.send(account, password, target, message)
      bot = GTalk::Bot.new(:email => account, :password=>password)
      bot.get_online
      bot.message target, message
  end
end
