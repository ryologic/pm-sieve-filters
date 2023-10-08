# pm-sieve-filters
Several sieve filters of varying quality, intended for use with Proton Mail. Random chunks of knowledge and tips sprinkled in here and there.

[Proton Mail](https://proton.me/mail) is a Swiss operated privacy oriented email service that supports filtering of inbound emails by use of [Sieve](https://datatracker.ietf.org/doc/html/rfc5228), a scripting language designed for the express purpose of managing email. Sieve is not exclusive to Proton Mail, many servers use it, but there can be platorm dependent quirks in the implementation. If you use any of this code, you should test it to your satisfaction before using any "destructive" functionality.

There are many examples online of how to perform [basic sieve filtering](https://p5r.uk/blog/2011/sieve-tutorial.html), but fewer advanced ones. Part of the intent of this repository is to improve on that.
