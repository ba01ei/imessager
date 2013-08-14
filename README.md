Summary
=======

iMessager is a tool to convert gmail (and potentially other triggers) to iMessage.

It runs on Mac OS, creates a cron job, and use Messages app to send the iMessage.

Usage
=====

1. Setup Messages app. Login with an iCloud account that can send iMessage. Make sure Messages app is running.
2. Edit config.rb, add the gmail account, password, and a phone number where you receive iMessage.
3. Open Terminal app, run the command "sudo gem install gmail". (If you are a ruby developer, you can just call bundle install in imessager folder.)
4. Run ./setup.rb in Terminal app in the imessager folder. (e.g. if you downloaded imessager to Downloads folder, you can enter: "cd ~/Downloads", return, and then "./setup.rb" and return)

Optionally, you can also go to your gmail and mark the most recent email as unread, and call "./testnow.rb" in Terminal app in the imessager folder to test if the iMessage can be successfully sent.


Developing new features
=======================

Developers can create new triggers other than gmail (e.g. other email system, weather, news, feeds, etc). To create a new one, please follow this convention:

1. Make a name for the plugin, e.g. RssFeed
2. Create an rb file in the plugins folder using the same name as the plugin but in lower case, e.g. plugins/rssfeed.rb
3. In the rb file, define a class with the same name, e.g. class RssFeed. Implement a class method self.run which takes a config dictionary as input and returns an array of iMessage strings.
4. In config.rb, add an entry in TRIGGERS, with the plugin name as the key, and the config dictionary as the value. Make sure that the config dictionary should at least have a key "period". E.g. "RssFeed" => {"period"=>"5", "url"=>"the feel url"}


License
=======

Copyright (c) 2013 Bao Lei

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


