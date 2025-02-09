//
//  main.m
//  libavifExample
//
//  Created by lizhuoli on 2019/4/14.
//  Copyright © 2019 SDWebImage. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<libavif/libavif.h>)
#include <libavif/libavif.h>
#else
#include "avif/avif.h"
#endif
#if __has_include(<complianceWarden/src/core/spec.h>)
#include <complianceWarden/src/core/spec.h>
#else
#include "core/spec.h"
#endif

SpecDesc const * specFind(const char * name);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        specFind("avif");
        NSLog(@"Hello, World!");
        printf("%s", avifVersion());
    }
    return 0;
}
