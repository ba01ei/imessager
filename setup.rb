#!/usr/bin/env ruby

DIR = File.expand_path(File.dirname(__FILE__))
RUNNER = File.join(DIR, "lib", "run_tasks.rb")
require File.join(DIR, "config.rb")

if __FILE__ == $0
  script = "crontab -l > mycron\n";
  TRIGGERS.each do |trigger, config|
    script += "echo \"*/#{config["period"]}\t*\t*\t*\t*\tbash -l -c 'ruby #{RUNNER} #{trigger}'\" >> mycron\n"
  end
  script += "crontab mycron\n" +
            "rm mycron\n"
  `#{script}`
end
