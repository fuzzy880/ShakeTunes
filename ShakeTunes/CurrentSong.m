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
            [CurrentSong currentSong].repeat = -1;
        }
    }
    return currentSong;
}

+ (void) playSong
{
    if ([CurrentSong currentSong].nowPlayingSong) {
        NSError *error = nil;
        NSURL *songLocation = [[CurrentSong currentSong].nowPlayingSong valueForProperty:MPMediaItemPropertyAssetURL];
        [CurrentSong currentSong].musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songLocation error:&error];
        [CurrentSong currentSong].musicPlayer.numberOfLoops = [CurrentSong currentSong].repeat;
        [[CurrentSong currentSong].musicPlayer play];
    }
    
}

+ (void) resumeSong
{
    if ([CurrentSong currentSong].nowPlayingSong) {
        if ([CurrentSong currentSong].musicPlayer) {
            [[CurrentSong currentSong].musicPlayer play];
        }
    }
    
}

+ (void) pauseSong
{
    [[CurrentSong currentSong].musicPlayer pause];
}

+ (BOOL) isPlaying
{
    NSLog([[CurrentSong currentSong].musicPlayer isPlaying] ? @"Yes" : @"No");
    return [[CurrentSong currentSong].musicPlayer isPlaying];
}

@end
