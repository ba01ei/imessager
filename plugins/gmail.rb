require 'gmail'
require 'aescrypt'
require 'base64'

class GMail

  def self.run(conf, testing)
    trace_back = testing ? 30*24*3600 : 30*24*3600
    output = []
    conf["accounts"].each do |account|
      # validate first
      if account["username"].to_s.length < 1
        puts "missing gmail user name"
        next
      elsif account["key"].to_s.length > 0
        private_key = File.read(File.join(File.expand_path(File.dirname(__FILE__)), "..", "data", ".key"))
        account["password"] = AESCrypt.decrypt(account["key"], private_key)
      end
      if account["password"].to_s.length < 1
        puts "missing gmail password"
        next
      end

      # sleep check
      t = Time.now
      t_num = t.hour * 100 + t.min
      sleeping = false
      if conf["sleep"]
        if conf["sleep"][0] > conf["sleep"][1]
          if t_num >= conf["sleep"][0] or t_num <= conf["sleep"][1]
            sleeping = true
          end
        else
          if t_num >= conf["sleep"][0] and t_num <= conf["sleep"][1]
            sleeping = true
          end
        end
        if sleeping
          puts "sleeping at this moment.." if testing
          return []
        end
      end

      Gmail.connect(account["username"], account["password"]) do |g|
        mails = g.inbox.emails(:unread, :after => (Time.now - trace_back))
        puts "new emails for #{account["username"]}: #{mails.count}" if testing
        last = -1
        if conf["limit"] and mails.count > conf["limit"]
          last = conf["limit"] - 1
          puts "mail range: 0..#{last}" if testing
        end
        mails[0..last].each do |m|
          bodytext = m.text_part ? m.text_part.body.to_s : (m.body.to_s.length > 0 ? m.body.to_s : "")
          t = Time.now.localtime
          message = "#{m.from[0].name}: #{m.subject} === #{bodytext}".gsub("&amp;", "&").gsub(/=\?WINDOWS-\d+\?Q\?/, "")[0..512] + " (#{t.hour}:#{t.min})"
          keep = false
          ignore = false
          subject_l = m.subject.downcase
          conf["keep"].each do |query|
            if subject_l.index(query.downcase)
              keep = true
              break
            end
          end
          conf["ignore"].each do |query|
             if subject_l.index(query.downcase)
               ignore = true
               break
             end
          end
          if keep
            m.unread!
          else
            m.read!
          end
          unless ignore
            output << message
          end
        end
      end
    end
    puts output.join("\n") if testing
    return output
  end
  
end