Summary
=======

iMessager is a tool to convert gmail (and potentially other triggers) to iMessage.

It runs on Mac OS, creates a cron job, and uses Messages app to send the iMessage.


Why this is built
=================

As of August 2013, Pebble smartwatch cannot consistently get email push notifications from iPhone. One workaround is to use IFTTT to convert gmail to sms, but sms is not free. That's why a tool to convert gmail to iMessage is more promising.

Other than pushing emails to Pebble, one use case of iMessager is that for people who get a lot of emails (e.g. if you subscribe to some news letters to your inbox), this tool helps you to mark everything as read automatically, and pushes brief previews to your iPhone, so that you can quickly get an idea of what is going on, skip most of the emails and read only the ones that you are very interested, without selecting every single mail in the mail client or web interface.

And potentially we can implement more feature on top of this. In addition to gmail, there are a lot of possibilities, e.g. tracking a news feed, the weather, or some other services like Facebook, Twitter, and convert various notifications into iMessage.

Usage
=====

To download the tool, non-developers can get the zip file at:
https://github.com/ba01ei/imessager/archive/master.zip

Developers can just clone this repository.

After downloading, follow the steps below to setup:

1. Setup Messages app. Login with an iCloud account that can send iMessage. Make sure Messages app is running.
2. Edit config.rb, add the gmail account, password, and a phone number where you receive iMessage. (There is a config.rb.example file you can follow.)
3. Open Terminal app, run the command "sudo gem install gmail". (If you are a ruby developer, you can just call bundle install in imessager folder.)
4. Run ./setup.rb in Terminal app in the imessager folder. (e.g. if you downloaded imessager to Downloads folder, you can enter: "cd ~/Downloads/imessager-master", return, and then "./setup.rb" and return)
5. To keep it working reliably, it's recommended to disable all the mechanisms that can lock the computer (e.g. uncheck System Preferences -> Security -> General -> Require password after sleep or screen saver begins), and make sure that the computer won't sleep when power adapter is plugged in.

Now a periodical job is scheduled. Depending on the settings in config.rb, once every few minutes it will automatically check your gmail inbox, send an iMessage for the new email, and mark it as read in the inbox.

To test if the setup is actually working, you can also go to your gmail and mark the most recent email as unread, and call "./testnow.rb" in Terminal app in the imessager folder to test if the iMessage can be successfully sent.

If you moved the folder to another location, you need to call ./setup.rb again.


Limitation
==========

Because there's no official iMessage API yet, this tool uses AppleScript to send iMessages through its user interface. This means that if you run this tool on a computer you actually use, there might be periodically interruptions. (e.g. when you are surfing the Internet, Messages app might suddenly pop up and automatically types some text.)

Therefore it is recommended to use a Mac that is not heavily used to run this job. (E.g. you have an old Mac and recently bought a new Macbook Air, the old Mac can sit in a corner in your bedroom and do this job with its screen turned off, while you are playing with your new Mac.)


Developing new features
=======================

Developers can create new triggers other than gmail (e.g. other email system, weather, news, feeds, etc). To create a new one, please follow this convention:

1. Make a name for the plugin, e.g. RssFeed
2. Create an rb file in the plugins folder using the same name as the plugin but in lower case, e.g. plugins/rssfeed.rb
3. In the rb file, define a class with the same name, e.g. class RssFeed. Implement a class method self.run which takes a config dictionary and a boolean "testing" as input and returns an array of iMessage strings. testing is true if the user is calling textnow.rb to just test the trigger.
4. In config.rb, add an entry in TRIGGERS, with the plugin name as the key, and the config dictionary as the value. Make sure that the config dictionary should at least have a key "period". E.g. "RssFeed" => {"period"=>"5", "url"=>"the feel url"}

Once you created a tempate for config.rb, it is recommended to call "git update-index --assume-unchange config.rb", so that your personal settings in config won't be pushed to git server.


License
=======

Copyright (c) 2013 Bao Lei

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


