require ["include", "environment", "variables", "relational", "regex", "fileinto"];

if anyof(
    allof (
        header :regex :comparator "i;ascii-casemap"
        "subject" "(autopay|posted|receipt of|verified receipt)"
        )
    ){
  return; # we want to ignore these because they're probably credit card related
}

elsif anyof(
    allof (
        header :regex :comparator "i;ascii-casemap" "subject" "(order|shipping|delivery|shipment)",
        header :regex :comparator "i;ascii-casemap" "subject" "(delivered|shipped|is.shipping|on.the.way|update|en.route|process(ed|ing|es)|pending|plac(ed|ing))"
        ),
    
    allof (
        header :regex :comparator "i;ascii-casemap" "subject" "(order|payment|receipt|purchase)",
        header :regex :comparator "i;ascii-casemap" "subject" "(thank.you|summary)"
        ),
          
    allof (
        header :regex :comparator "i;ascii-casemap" "subject" "your.*(order|payment|receipt)",
        not header :contains :comparator "i;ascii-casemap" "subject" "schedul"
        ),
                    
    allof (
        header :regex :comparator "i;ascii-casemap" "subject" "(payment|receipt|confirm)",
        header :regex :comparator "i;ascii-casemap" "subject" "(order)"
        )
    ){
  fileinto "orders";
  return;
}
