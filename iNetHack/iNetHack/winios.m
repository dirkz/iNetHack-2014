//
//  winios.m
//  iNetHack
//
//  Created by dirk on 18/10/14.
//  Copyright (c) 2014 Dirk Zimmermann. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <stdarg.h>
#import <stdio.h>
#import <stdlib.h>

#import "winios.h"

#pragma mark -- some needed functions for NetHack

// These must be defined but are not used (they handle keyboard interrupts).
void intron() {}
void introff() {}

void error(const char *s, ...) {
    //DLog(@"error: %s");
    char message[512];
    va_list ap;
    va_start(ap, s);
    vsprintf(message, s, ap);
    va_end(ap);
    NSLog(@"error: %s", message);
    // todo (button to wait for user?)
    exit(0);
}

void regularize(char *s) {
    register char *lp;
    for (lp = s; *lp; lp++) {
        if (*lp == '.' || *lp == ':')
            *lp = '_';
    }
}