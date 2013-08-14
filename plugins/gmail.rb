require 'gmail'

class GMail

  def self.run(conf)
    output = []
    conf["accounts"].each do |account|
      Gmail.connect(account["username"], account["password"]) do |g|
        mails = g.inbox.emails(:unread, :after => (Time.now - 300*conf["period"]))
        mails.each do |m|
         bodytext = "#{m.text_part.body}"
         output << "#{m.from[0].name}: #{m.subject}\n#{bodytext[0..199]}"
        end
      end
    end
    output
  end
  
end