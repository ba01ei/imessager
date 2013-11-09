#!/usr/bin/env ruby

DIR = File.expand_path(File.dirname(__FILE__))
RUNNER = File.join(DIR, "lib", "run_tasks.rb")
require File.join(DIR, "config.rb")

if __FILE__ == $0
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
