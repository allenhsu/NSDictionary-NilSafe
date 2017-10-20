//
//  Tests.m
//  Tests
//
//  Created by Allen Hsu on 6/22/16.
//  Copyright © 2016 Glow Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+NilSafe.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLiteral {
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    NSDictionary *dict = @{
        nonNilKey: nilVal,
        nilKey: nonNilVal,
    };
    XCTAssertEqualObjects([dict allKeys], @[]);
    XCTAssertNoThrow([dict objectForKey:nonNilKey]);
    id val = dict[nonNilKey];
    XCTAssertNil(val);
    XCTAssertNoThrow([val length]);
    XCTAssertNoThrow([val count]);
    XCTAssertNoThrow([val anyObject]);
    XCTAssertNoThrow([val intValue]);
    XCTAssertNoThrow([val integerValue]);
}

- (void)testKeyedSubscript {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    dict[nonNilKey] = nilVal;
    dict[nilKey] = nonNilVal;
    XCTAssertEqualObjects([dict allKeys], @[]);
    XCTAssertNoThrow([dict objectForKey:nonNilKey]);
}

- (void)testSetObject {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    [dict setObject:nilVal forKey:nonNilKey];
    [dict setObject:nonNilVal forKey:nilKey];
    XCTAssertEqualObjects([dict allKeys], @[]);
    XCTAssertNoThrow([dict objectForKey:nonNilKey]);
}

- (void)testArchive {
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    NSDictionary *dict = @{
        nonNilKey: nilVal,
        nilKey: nonNilVal,
    };
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    NSDictionary *dict2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    XCTAssertEqualObjects([dict2 allKeys], @[]);
    XCTAssertNoThrow([dict2 objectForKey:nonNilKey]);
}

- (void)testJSON {
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    NSDictionary *dict = @{
        nonNilKey: nilVal,
        nilKey: nonNilVal,
    };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *expectedString = @"{}";
    XCTAssertEqualObjects(jsonString, expectedString);
}

@end
