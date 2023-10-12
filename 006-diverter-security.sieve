require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "fileinto", "imap4flags", "vnd.proton.expire", "regex"];

##############################################################
### Capture all security events and folder them
##############################################################

# matches a wide variety of login/log-in/sign on strings
if header :regex :comparator "i;ascii-casemap" "subject" "(sign(ed|ing)?|log(ged|ging)?)[ _-]?[io]n" {
  fileinto "Security";
  fileinto "testlabel";
  stop;
}

# matches various security notices
elsif header :regex :comparator "i;ascii-casemap" "subject"
"(((2|two)([ _-]factor|[ _-]?FA))|secur(e|ity)|otp|one[-]?time).+(alert|noti|code|pass|conf)" {
  fileinto "Security";
  fileinto "testlabel";
  stop;
}

# matches a wide variety of login/log-in/sign on/sign-in strings
if header :regex :comparator "i;ascii-casemap" "subject" "(sign(ed|ing)?|log(ged|ging)?)[ _-]?[io]n" {
  fileinto "Security";
  fileinto "testlabel";
  stop;
}

# matches assorted account change notices, might have a few false positives.
if allof(
    header :regex :comparator "i;ascii-casemap" "subject" "(secur(e|ity)|address|(e.?)?mail|account|preference|device|password|contact)", #noun (ish)
    header :regex :comparator "i;ascii-casemap" "subject" "(change[ds]?|verif|retriev|request|confirm|[ ^]new )" #verb (ish)
    ){
      fileinto "Security";
      fileinto "testlabel";
  stop;
}

# a few more strings to filter on
if anyof(
    header :contains "subject" [
    "creating an account",
    "terms of service"
    ]
    ){
  fileinto "Security";
  fileinto "testlabel";
  expire "day" "3";
  stop;
}
return;

### miscellaneous regex strings to test later ###
# ^.*(?i)(?:sign(?:ed|ing)?|log(?:ged|ging)?)[\s_-]?[io]n.*(?-i)$
# secur(?:e|ity)|chang(?:e[ds]?|ing)|(?:verif|confirm|inform)
# secur(?:e|ity).+(alert|\bnoti|code\b|\bpass|\bconf)
#(?:your|account|have|has|recent(ly)?)\bchang(?:e[ds]?\b)
#|(?:verif|confirm|inform)
