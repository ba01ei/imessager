
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
             "  keystroke \"#{text.gsub("\"", "\\\"").gsub("'", "\\'").gsub("\t", " ")}\"\n" +
             "  keystroke return\n" +
             "end tell"
    script
  end

  # sends an imessage
  def self.send(phone, text)
    puts "apple script: #{self.apple_script(phone, text)}"
    `osascript -e '#{self.apple_script(phone, text)}'`
  end
end

