
class IMessageSender

  # constructs the apple script  
  def self.apple_script(phone, text)
    script = "tell application \"Messages\" to activate\n" +
             "delay 1\n" +
             "tell application \"System Events\"\n" +
             "  keystroke \"f\" using {command down}\n" +
             "  delay 0.5\n" +
             "  keystroke tab\n" +
             "  delay 0.5\n" +
             "  keystroke \"n\" using {command down}\n" +
             "	delay 0.5\n" +
             "  keystroke \"#{phone}\"\n" +
             "  keystroke return\n" +
             "	delay 0.5\n" +
             "  keystroke tab\n" +
             "  delay 0.5\n" +
             "  keystroke \"a\" using {command down}\n" +
             "	delay 0.5\n" +
             "  keystroke \"#{text.gsub("\"", "`").gsub("'", "`").gsub("\t", " ")}\"\n" +
             "  keystroke return\n" +
             "end tell"
    script
  end

  # sends an imessage
  def self.send(phone, text)
    # puts "apple script: #{self.apple_script(phone, text)}"
    result = system("osascript -e '#{self.apple_script(phone, text)}'")
    unless result
      puts "error executing applescript. sending simplified version.."
      simple = text.gsub(/[^0-9a-z]/i, ' ')
      system("osascript -e '#{self.apple_script(phone, simple)}'")
    end
  end
end

