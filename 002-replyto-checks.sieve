require [
"include",
"environment",
"variables",
"relational",
"comparator-i;ascii-numeric",
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
  if anyof(
      not header :matches "From" "${1}",
      not header :matches "X-Pm-Original-From" "${1}"
      ){
    fileinto "warn-reply"; #LABEL
  }
}
return; #stop here for now

#check if domain of reply address is different than the from address
#TODO get this actually working
#TODO get this set up to work for SL and non-SL emails
if header :regex :comparator "i;ascii-casemap" "X-Pm-Original-From" "([ ]at[ ]|\(at\))(.*)\"?"{
  set "suffix" "$2";
  if allof(
      not header :regex :comparator "i;ascii-casemap" "Reply-To" "([ ]at[ ]|\(at\))${suffix}"
      # TODO swap the logic around so it works for both SL and non-SL emails
      ){
    #fileinto "warn-tld"; #LABEL
  }
}
