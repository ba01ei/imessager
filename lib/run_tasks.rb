#!/usr/bin/env ruby

DIR = File.expand_path(File.dirname(__FILE__))
CONF_FILE =  File.join(DIR, "..", "config.rb")
require CONF_FILE
require File.join(DIR, "imessage_sender.rb")

if __FILE__ == $0
  if ARGV.count < 1
    puts "Please specify a trigger, e.g. GMail"
    exit(0)
  end

  # sleep check
  t = Time.now
  t_num = t.hour * 100 + t.min
  sleeping = false
  if File.read(CONF_FILE).index("SLEEP")
    if SLEEP[0] > SLEEP[1]
      if t_num >= SLEEP[0] or t_num <= SLEEP[1]
        sleeping = true
      end
    else
      if t_num >= SLEEP[0] and t_num <= SLEEP[1]
        sleeping = true
      end
    end
    if sleeping
      # sleeping
      exit(0)
    end
  end

  trigger = ARGV[0]
  testing = (ARGV.count >= 2 and ARGV[1] == "test")

  require File.join(DIR, "..", "plugins", trigger.downcase + ".rb")
  cls = Object.const_get(trigger)
  messages = cls.run(TRIGGERS[trigger], testing)
  # puts "messages: #{messages.count}"
  RECEIVERS.each do |phone|
    if phone.to_s.length < 1
      next
    end
    messages.each do |txt|
      IMessageSender.send(phone, txt) if txt.to_s.length > 0
      sleep 2
    end
  end
end