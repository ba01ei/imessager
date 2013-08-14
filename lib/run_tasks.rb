#!/usr/bin/env ruby

DIR = File.expand_path(File.dirname(__FILE__))
require File.join(DIR, "config.rb")
require File.join(DIR, "lib", "imessage_sender.rb")

if __FILE__ == $0
  testing = (ARGV.count >= 1 and ARGV[0] == "test")
  TRIGGERS.each do |k, v|
    require File.join(DIR, "plugins", k.downcase + ".rb")
    cls = Object.const_get(k)
    messages = cls.run(v, testing)
    RECEIVERS.each do |phone|
      messages.each do |txt|
        IMessageSender.send(phone, txt)
      end
    end
  end
end