
TRIGGERS = {
  "GMail" => {
    "accounts" => [
      {"username" => "enter your gmail", 
      "password" => "enter your gmail password",
      },
    ],
    "keep" => ["[Reminder]", "[important]"],
    "ignore" => ["spam"],
    "limit" => 2, # max number of emails pushed at once per gmail account
    "period" => 5  # polling period in minutes
  },
  "Web" => {
    "period" => 5,
    "sites" => [
      {
#        "url" => "https://www.google.com",
#        "alert_any_not_exist" => ['google'],
      },
    ],
  }
}

SLEEP = [2330, 900]

RECEIVERS = [
#  "enter your iphone number",  # iPhone phone number here
]

GTALK_SENDER = {
  "username"=>"enter your secondary gmail",
  "password" => "enter your secondary gmail password",
}
GTALK_RECEIVERS = [
  "enter your primary gmail",
]
