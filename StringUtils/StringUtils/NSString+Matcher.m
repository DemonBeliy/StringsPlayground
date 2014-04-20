//
//  NSString+Matcher.m
//  StringUtils
//
//  Created by Dima Belov on 20.04.14.
//
//

#import "NSString+Matcher.h"


@implementation NSString (Matcher)

-(BOOL) containsString:(NSString*) pattern {
   
    if([pattern length] == 0) return NO;
    
    int patternLength = pattern.length;
    int textLength = self.length;
    
    int pi[patternLength]; //array containing the failure function
    
    const char * p = [pattern UTF8String];
    
    pi[0] = -1;
    for(int i = 1, k = 0; i < patternLength; i++) {
        while(k >= 0 && p[k] != p[i]) {
            k = pi[k];
        }
        pi[i] = k;
        k++;
    }
    
    const char * t = [self UTF8String];
    
    for(int i = 0, k = 0; i < textLength; i++) {
        while(k >= 0 && p[k] != t[i]) { //Mismatch detected, jump
            k = pi[k];
        }
        k++;
        if(k == patternLength) { //Matched pattern
            return YES;
        }
    }
    return NO;
}

@end
