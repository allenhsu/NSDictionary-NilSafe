//
//  NSDictionary+NilSafe.h
//  NSDictionary-NilSafe
//
//  Created by Allen Hsu on 6/22/16.
//  Copyright © 2016 Glow Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NilSafe)

@end

@interface NSMutableDictionary (NilSafe)

@end

static struct __gl_block_descriptor {
    unsigned long int reserved;
    unsigned long int size;
} __gl_block_descriptor = { 0, sizeof(struct __gl_block_descriptor) };

@interface GLNull : NSObject <NSCopying, NSCoding> {
    int flags;
    int reserved;
    void *(*invoke)(__weak GLNull *, ...);
    struct __gl_block_descriptor *descriptor;
    const int x;
}

+ (GLNull *)null;

@end
