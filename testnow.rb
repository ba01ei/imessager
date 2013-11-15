#!/usr/bin/env ruby

DIR = File.expand_path(File.dirname(__FILE__))
CONF_FILE = File.join(DIR, "config.private.rb")
CONF_FILE = File.join(DIR, "config.rb") unless File.exists? CONF_FILE
require CONF_FILE
p CONF_FILE

TRIGGERS.each do |k, v|
  puts "testing #{k}..."
  cmd = "#{File.join(DIR, "lib", "run_tasks.rb")} #{k} test"
  puts cmd
  system cmd
end
