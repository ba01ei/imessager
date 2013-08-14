
class IMessageSender

  # constructs the apple script  
  def self.apple_script(phone, text)
    script = "tell application \"Messages\" to activate\n" +
             "tell application \"System Events\"\n" +
             "  keystroke \"n\" using {command down}\n" +
             "  keystroke \"#{phone}\"\n" +
             "  keystroke return\n" +
             "  keystroke tab\n" +
             "  keystroke \"#{text.gsub("\"", "\\\"").gsub("'", "\\'")}\"\n" +
             "  keystroke return\n" +
             "end tell"
    script
  end

  # sends an imessage
  def self.send(phone, text)
    # puts "apple script: #{self.apple_script(phone, text)}"
    `osascript -e '#{self.apple_script(phone, text)}'`
  end
end

