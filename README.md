Summary
=======

iMessager is a tool to watch for new emails from gmail or changes on a website, and notifies you through iMessage or Google talk.

It runs on Mac OS, and requires the computer to be on and connected to Internet.


Why this is built
=================

Initially this is built to address the issue that Pebble smartwatch cannot consistently receive email notifications. So its main job is to convert emails to iMessages.

After iOS 7, the Pebble notification issue was fixed, but this tool can still be helpful by selecting which emails to push, which emails to ignore, and which emails to keep pushing. Also it makes it easy to scan changes on websites.

Usage
=====

*** If you plan to use iMessage ***

1. Setup Messages app. Login with an iCloud account that can send iMessage. Make sure Messages app is runnin
2. Edit config.rb, add the gmail account, password, and a phone number where you receive iMessage (There is a config.rb.example file you can follow.)
3. Open Terminal app, run the command "gem install bundler; bundle install"
4. Run ./setup.rb


*** If you plan to use Google Talk ***

1. If you use an iPhone, install Hangouts app, sign in your primary account.
2. You need to have a secondary Google account in order to send messages to your primary account.
3. Edit config.rb, add the gmail account, password, and the sender/receiver Google talk accounts (There is a config.rb.example file you can follow.)
4. Run ./setup.rb


To test if the setup is actually working, you can also go to your gmail and mark the most recent email as unread, and call "./testnow.rb" in Terminal app in the imessager folder to test if the iMessage can be successfully sent.

If you moved the folder to another location, you need to call ./setup.rb again.



Developing new features
=======================

Developers can create new triggers other than gmail (e.g. other email system, weather, news, feeds, etc). To create a new one, please follow this convention:

1. Make a name for the plugin, e.g. RssFeed
2. Create an rb file in the plugins folder using the same name as the plugin but in lower case, e.g. plugins/rssfeed.rb
3. In the rb file, define a class with the same name, e.g. class RssFeed. Implement a class method self.run which takes a config dictionary and a boolean "testing" as input and returns an array of message strings. testing is true if the user is calling textnow.rb to just test the trigger.
4. In config.rb, add an entry in TRIGGERS, with the plugin name as the key, and the config dictionary as the value. Make sure that the config dictionary should at least have a key "period". E.g. "RssFeed" => {"period"=>"5", "url"=>"the feel url"}

For developers, it is recommended to use config.private.rb to store your personal settings, and use config.rb as a template.


License
=======

Copyright (c) 2013 Bao Lei

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


