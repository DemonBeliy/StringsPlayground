//
//  StringUtilsTests.m
//  StringUtilsTests
//
//  Created by Dima Belov on 20.04.14.
//
//

#import <XCTest/XCTest.h>
#import "NSString+Matcher.h"
#import "BDVStringTestData.h"


/**
 Helper object describing a collection of tests run on a pattern matching method
 */
@interface StringPerformanceTest : NSObject

/**
 Total time spent in KMP function
 */
@property (nonatomic, assign) CFTimeInterval KMP;
/**
 Total time spent in System function
 */
@property (nonatomic, assign) CFTimeInterval System;

/**
 Number of times KMP & System functions were executed each
 */
@property (nonatomic, assign) NSUInteger numberOfTests;

/**
 String pattern being searched for
 */
@property (nonatomic, copy)   NSString * pattern;

@end

@implementation StringPerformanceTest

@end

@interface StringUtilsTests : XCTestCase
/**
    Contains a mapping of patterns to their test results, used to aggregate test data
 */
@property (nonatomic, strong) NSMutableDictionary * testResults;
@end

@implementation StringUtilsTests

+(NSArray*) patterns {
    static NSArray * testPatterns;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        testPatterns = @[@"", @"accumsan",
                         @"imperdiet",
                         @"Epic fail... or is it?",
                         @"egestas tempus. Morbi at fringilla metus. Praesent faucibus risus ut lacus viverra imperdiet. Ut tempor sapien id pellentesque venenatis. Integer vitae elementum nibh. Proin lorem est, mattis at odi",
                         @"e. Maecenas tempor, lectus et congue tempus, leo massa facilisis neque, eu imperdiet dolor mauris in augue. Nam vel dui nulla. Sed malesuada ligula lacinia lacus egestas tempus. Morbi at fringilla metus. Praesent faucibus risus ut lacus viverra imperdiet. Ut tempor sapien id pellentesque venenatis. Integer vitae elementum nibh. Proin lorem est, mattis at odio id, tincidunt viverra est. Aenean interdum porta velit id laoreet. Donec orci eros, lacinia eu pulvinar et, molestie nec magna. Aenean in tellus urna. Duis nisl lectus, euismod non dignissim ac, egestas quis justo. Nulla eget quam in turpis gravida accumsan. Nullam ultricies placerat augue, eu eleifend diam pulvinar ac. Ut ipsum magna, luctus et accumsan id, pharetra dictum justo. Pellentesque nec tincidunt nisi. Vivamus eget aliquam urna, ut ultrices mi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam suscipit tortor convallis erat dapibus, ut tristique nisl sollicitudin. Quisque sed odio sem. Sed non orci sit amet tortor consectetur faucibus nec interdum dui. Suspendisse non accumsan libero. Duis enim enim, consequat vitae sapien nec, mattis ornare libero. Nunc ac quam sit amet diam aliquet mollis."];
    });
    return testPatterns;
}


- (void)setUp
{
    [super setUp];
    
    //Initialize the data structure to keep results of all tests
    
    self.testResults = [NSMutableDictionary dictionary];
    NSMutableArray * testResultsDetails = [NSMutableArray array];
    [[[self class] patterns] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        StringPerformanceTest * test = [[StringPerformanceTest alloc]init];
        test.pattern = obj;
        [testResultsDetails addObject:test];
        self.testResults[obj] = test;
    }];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testInvalidData {
    XCTAssertFalse([text containsString:nil],@"nil input should not produce true");
}

-(void) testCorrectness {
    [[[self class] patterns] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
         XCTAssertTrue([text containsString:obj] == ([text rangeOfString:obj].length != 0), @"containsString should results must match the systemFunction");
    }];
}

-(void) testPerformance
{
    NSArray * patterns = [[self class] patterns];
    for(int i = 0; i < 5000; i++) {
        [patterns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            StringPerformanceTest * result = self.testResults[obj];
            
            CFTimeInterval startTimeInterval = CACurrentMediaTime();
            [text containsString:obj];
            CFTimeInterval nowTimeInterval = CACurrentMediaTime();
            CFTimeInterval KMP = nowTimeInterval - startTimeInterval;
            
            result.KMP += KMP;
            
            startTimeInterval = CACurrentMediaTime();
            [text rangeOfString:obj];
            nowTimeInterval = CACurrentMediaTime();
            CFTimeInterval System = nowTimeInterval - startTimeInterval;
            
            result.System += System;
            result.numberOfTests++;
            
        }];
    }
    
    [patterns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        StringPerformanceTest * testResult = self.testResults[obj];
        
        NSLog(@"Average KMP: %f - Average System: %f - Total: %f vs %f",
              testResult.KMP/testResult.numberOfTests,
              testResult.System/testResult.numberOfTests,
              testResult.KMP,
              testResult.System);
    }];
}


@end
