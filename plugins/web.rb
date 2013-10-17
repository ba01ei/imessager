
require 'open-uri'
require 'timeout'

class Web
  def self.run(conf, testing)
    output = []
    conf["sites"].each do |site|
      puts "working on: " + site["url"] if testing
      begin
        timeout(15) do
          result = open(site["url"]).read()
          puts result if testing
          site["alert_any_not_exist"].each do |phrase|
            if not result.index(phrase)
              output << "Missing [#{phrase}] in #{site['url']}"
            elsif testing
              puts "Found #{phrase} in #{site['url']}"
            end
          end
        end
      rescue => error
        if testing
          puts "down: " + site["url"]
        end
      end
    end
    return output
  end
end
