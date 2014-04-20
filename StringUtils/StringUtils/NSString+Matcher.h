//
//  NSString+Matcher.h
//  StringUtils
//
//  Created by Dima Belov on 20.04.14.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Matcher)

/**
    Runs a KMP pattern matcher to check if pattern is a substring of this string.
 */
-(BOOL) containsString:(NSString*)pattern;

@end
