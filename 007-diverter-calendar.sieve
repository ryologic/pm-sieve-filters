require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "fileinto", "imap4flags"];
# require ["vnd.proton.expire"];

##############################################################
### Calendar Invites & Notifications
##############################################################

if anyof (
    address :matches :domain "from" ["calendar.proton.me"],
    header  :matches  "X-Attached" ["calendar.ics", "invite.ics"]
    )
       {
        fileinto "Calendar"; #FOLDER
       }
