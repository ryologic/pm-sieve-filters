require [
"include",
"environment",
"variables",
"relational",
"comparator-i;ascii-numeric",
"spamtest",
"fileinto",
"imap4flags",
"envelope"
];

# If spam, then spam. Easy-simple. NOTE: All future scripts assume
# that this is the first thing that runs so it can be removed
# from all following sieve scripts. Customize accordingly.
if allof(
    environment :matches "vnd.proton.spam-threshold" "*",     # if - you have a threshold set (checking for literal *)
    spamtest :value "ge" :comparator "i;ascii-numeric" "${1}" # then - check if you hit it
    ){
  fileinto "Spam"; #FOLDER
  stop;
}

# Check for basic anti-spoofing, authentication, and unencrypted messages
# this is probably handled far better by the spamtest above, but hey, why not?
if anyof( 
    header :is "x-pm-transfer-encryption" "none", # Plaintext? At this time of year?
    header :contains "Authentication-Results" "dkim=fail", # DKIM auth fail
    header :contains "Authentication-Results" "spf=fail",  # SPF auth fail
    header :contains "Authentication-Results" "spf=none"   # No SPF at all
    ){
  fileinto "Spam"; # FOLDER
  stop; 
}
