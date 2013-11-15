#!/usr/bin/env ruby

require 'base64'
require 'aescrypt'

DIR = File.expand_path(File.dirname(__FILE__))
RUNNER = File.join(DIR, "lib", "run_tasks.rb")
CONFIG = File.join(DIR, "config.rb")
require CONFIG

def setup_cron
  script = `crontab -l`;
  old_lines = script.split("\n")
  lines = []
  # puts lines.count
  old_lines.each do |line|
    if line.index("run_tasks")
      # old_lines.delete(line)
    else
      lines << line
    end
  end
  TRIGGERS.each do |trigger, config|
    lines << "*/#{config["period"]}\t*\t*\t*\t*\tbash -l -c 'ruby #{RUNNER} #{trigger}'"
  end
  File.open("mycron", "w") do |f|
    f.write(lines.join("\n") + "\n")
  end
  script = "crontab mycron\n" +
           "rm mycron\n"
  `#{script}`
end

def setup_keys
  reveal = ARGV[0] == "reveal"
  key_file = File.join(DIR, "data", ".key")
  old_private_key = File.exist?(key_file) ? File.read(key_file) : nil
  new_private_key = Base64.encode64(rand().to_s).strip
  File.write(key_file, new_private_key)
  conf = File.read(CONFIG)
  conf.scan(/(\"key\"\s*\=\>\s*\"([^\"]+)\")/).each do |pubkey|
    line = pubkey[0]
    key = pubkey[1]
    if old_private_key
      # puts "AESCrypt.decrypt(#{key}, #{old_private_key})"
      pass = AESCrypt.decrypt(key, old_private_key)
      new_pub_key = AESCrypt.encrypt(pass, new_private_key).strip
      if reveal
        conf.gsub!(line, "\"password\" => \"#{pass}\"")
      else
        conf.gsub!(line, "\"key\" => \"#{new_pub_key}\"")
      end
    else
      # oops, missing old key
      conf.gsub!(line, "\"password\" => \"enter your password\"")
    end
  end
  if not reveal
    conf.scan(/(\"password\"\s*\=\>\s*\"([^\"]+)\")/).each do |password|
      line = password[0]
      pass = password[1]
      new_pub_key = AESCrypt.encrypt(pass, new_private_key).strip
      conf.gsub!(line, "\"key\" => \"#{new_pub_key}\"")
    end
  end

  File.write(CONFIG, conf)
end

if __FILE__ == $0
  setup_cron
  setup_keys
end
