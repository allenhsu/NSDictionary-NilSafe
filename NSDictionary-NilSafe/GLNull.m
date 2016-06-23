//
//  GLNull.m
//  NSDictionary-NilSafe
//
//  Created by Allen Hsu on 6/23/16.
//  Copyright © 2016 Glow Inc. All rights reserved.
//

#import "GLNull.h"

@implementation GLNull

+ (GLNull *)null {
    static id null;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        null = [[self alloc] init];
    });
    return null;
}

- (id)init {
    self = [super init];
    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark Forwarding machinery

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        // nothing to do
        return;
    }

    // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);

    [anInvocation setReturnValue:buffer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *sig = [super methodSignatureForSelector:selector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
}

- (BOOL)respondsToSelector:(SEL)selector {
    // behave like nil
    return NO;
}

#pragma mark NSObject protocol

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return NO;
}

- (NSUInteger)hash {
    return 0;
}

- (BOOL)isEqual:(id)obj {
    return !obj || obj == self || [obj isEqual:[NSNull null]];
}

- (BOOL)isKindOfClass:(Class)class {
    return [class isEqual:[GLNull class]] || [class isEqual:[NSNull class]];
}

- (BOOL)isMemberOfClass:(Class)class {
    return [class isEqual:[GLNull class]] || [class isEqual:[NSNull class]];
}

- (BOOL)isProxy {
    // not really a proxy -- we just inherit from NSProxy because it makes
    // method signature lookup simpler
    return NO;
}

@end