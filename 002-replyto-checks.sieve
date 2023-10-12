require [
"include",
"environment",
"variables",
"relational",
"fileinto",
"imap4flags",
"envelope",
"regex"
];
###################################

# check if from address is the same as replyto address
# currently testing, not always an indicator of trash emails
# false positives on survey requests and proton customer support tickets
if header :regex :comparator "i;ascii-casemap" "Reply-To" "(.*)"{
  if not anyof(
      header :matches "From" "${1}",
      header :matches "X-Pm-Original-From" "${1}"
      ){
    fileinto "warn-reply"; #LABEL
  }
