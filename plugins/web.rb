
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
          missing = []
          site["alert_any_not_exist"].each do |phrase|
            if not result.index(phrase)
              missing << phrase
              # output << "Missing [#{phrase}] in #{site['url']}"
            elsif testing
              puts "Found #{phrase} in #{site['url']}"
            end
          end
          if missing.length > 0
            output << "Missing #{missing.join(',')} in #{site['url']}"
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
