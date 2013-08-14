require 'gmail'

class GMail

  def self.run(conf, testing)
    trace_back = testing ? 1000000 : 10
    output = []
    conf["accounts"].each do |account|
      Gmail.connect(account["username"], account["password"]) do |g|
        mails = g.inbox.emails(:unread, :after => (Time.now - trace_back*60*conf["period"]))
        puts "new emails for #{account["username"]}: #{mails.count}" if testing
        mails.each do |m|
         bodytext = "#{m.text_part.body}"
         output << "#{m.from[0].name}: #{m.subject}\n#{bodytext[0..199]}"
         m.read!
        end
      end
    end
    puts output.join("\n") if testing
    return output
  end
  
end