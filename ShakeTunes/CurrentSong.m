//
//  CurrentSong.m
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "CurrentSong.h"

@implementation CurrentSong

static CurrentSong *currentSong = nil;

+ (CurrentSong *) currentSong
{
    @synchronized(self) {
        if (!currentSong) {
            currentSong = [[CurrentSong alloc] init];
        }
    }
    return currentSong;
}

@end
