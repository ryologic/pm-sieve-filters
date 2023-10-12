require ["include", "regex", "environment", "variables", "relational", "comparator-i;ascii-numeric", "fileinto", "imap4flags", "vnd.proton.expire"];

##################################################
### Label all mail containing an unsubscribe list
### as an advertisement, unless it is from Proton,
### Simple Login, or on the user whitelist below
##################################################

# TODO verify subdomain matching behavior
# TODO verify if subdomain matching behavior matters...

if anyof (
    address :contains :domain "from" [
    "yourdomain.fart",
    # add whitelist domains above this line, each line must end with a comma
    "proton.me", 
    "protonmail.com",
    "pm.me",
    "protonmail.ch"
    ]
    ){
  return;
}

elsif anyof (
    allof (
        header :regex :comparator "i;ascii-casemap" "subject" "(\d+%)",
        header :regex :comparator "i;ascii-casemap" "subject" "(coupon|discount|off|less)"
        ),
    allof (
        header :contains :comparator "i;ascii-casemap" [
        "list-unsubscribe",
        "Feedback-ID",
        "List-Unsubscribe",
        "X-Campaign",
        "X-campaignid",
        "X-Feedback-ID",
        "X-mail_abuse_inquiries",
        "X-maillist-guid",
        "X-maillist-id",
        "X-MC-User",
        "X-Feedback-ID",
        "X-rpcampaign",
        "X-Unsubscribe-Web"
        ] [""] # new syntax, not sure this works yet
        )
    ){
      fileinto "Ads"; #LABEL
    }

