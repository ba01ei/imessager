require 'gmail'

class GMail

  def self.run(conf, testing)
    trace_back = testing ? 1000000 : 10
    output = []
    conf["accounts"].each do |account|
      # validate first
      if account["username"].to_s.length < 1 or account["password"].to_s.length < 1
        puts "missing gmail user name or password"
        return []
      end

      Gmail.connect(account["username"], account["password"]) do |g|
        mails = g.inbox.emails(:unread, :after => (Time.now - trace_back*60*conf["period"]))
        puts "new emails for #{account["username"]}: #{mails.count}" if testing
        mails.each do |m|
         bodytext = m.text_part ? m.text_part.body.to_s : (m.body.to_s.length > 0 ? m.body.to_s : "")
         output << "#{m.from[0].name}: #{m.subject} === #{bodytext}"[0..2048]
         m.read!
        end
      end
    end
    puts output.join("\n") if testing
    return output
  end
  
end