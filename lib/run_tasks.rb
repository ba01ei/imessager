#!/usr/bin/env ruby

DIR = File.expand_path(File.dirname(__FILE__))
require File.join(DIR, "..", "config.rb")
require File.join(DIR, "imessage_sender.rb")

if __FILE__ == $0
  if ARGV.count < 1
    puts "Please specify a trigger, e.g. GMail"
    exit(0)
  end
  trigger = ARGV[0]
  testing = (ARGV.count >= 2 and ARGV[1] == "test")

  require File.join(DIR, "..", "plugins", trigger.downcase + ".rb")
  cls = Object.const_get(trigger)
  messages = cls.run(TRIGGERS[trigger], testing)
  # puts "messages: #{messages.count}"
  RECEIVERS.each do |phone|
    if phone.to_s.length < 1 or txt.to_s.length < 1
      next
    end
    messages.each do |txt|
      IMessageSender.send(phone, txt)
      sleep 2
    end
  end
end