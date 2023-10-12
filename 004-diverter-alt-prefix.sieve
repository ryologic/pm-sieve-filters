require [
"include",
"environment",
"variables",
"relational",
"fileinto",
"imap4flags",
"regex"
];

# sorts out emails sent to addresses of the commented formats
if anyof(
    header :regex "X-Original-To" "^.*alt\d\d+@.*\..*$", # bingusalt12345@dingus.bongus
    header :regex "X-Original-To" "^.*[+].*@.*\..*$" # bingus+dingus@bongus.dongus
    ){
  #set :lower "subdomain" "${2}";
  #set :lower :upperfirst "prefix" "${1}";
  fileinto "Alt";
}

return;
