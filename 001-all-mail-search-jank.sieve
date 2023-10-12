require [
"include",
"environment",
"variables",
"relational",
"comparator-i;ascii-numeric",
"spamtest",
"fileinto"
];

### This is an incredibly stupid filter. It just
### slaps a label on everything that isn't obviously
### spam. The idea is when you send things to trash,
### you can remove this label, then use it for
### searching all mail excluding trash. (angy noises)

# Default Proton Spamtest
if allof (environment :matches "vnd.proton.spam-threshold" "*",
spamtest :value "ge" :comparator "i;ascii-numeric" "${1}")
{
    return;
}

# slap a sticker on it
if true {
  fileinto "all"; # This is so dumb.
}

return;
