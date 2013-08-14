#!/usr/bin/env ruby

DIR = File.expand_path(File.dirname(__FILE__))
require File.join(DIR, "config.rb")

TRIGGERS.each do |k, v|
  puts "testing #{k}..."
  cmd = "#{File.join(DIR, "lib", "run_tasks.rb")} #{k} test"
  puts cmd
  system cmd
end
