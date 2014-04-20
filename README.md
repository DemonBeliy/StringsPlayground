Playground
=====================
Contains various Objective-C utility methods that I've decided to implement while playing around with various algorithms.


StringUtils
---------

- NSString-Matcher
    - a category implementing: **-(BOOL) containsString:(NSString *) pattern;** method on NSString using Knuth–Morris–Pratt algorithm
    - includes unit tests for correctness
    - includes a small performance setup comparing it to the rangeOfString method on NSString

