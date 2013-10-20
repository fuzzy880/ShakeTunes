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
            currentSong.musicPlayer = [[AVPlayer alloc] init];
        }
    }
    return currentSong;
}

+ (void) playSong
{
    if ([CurrentSong currentSong].nowPlayingSong) {
        AVPlayerItem *avSong = [AVPlayerItem playerItemWithURL:[[CurrentSong currentSong].nowPlayingSong valueForProperty:MPMediaItemPropertyAssetURL]];
        [[CurrentSong currentSong].musicPlayer replaceCurrentItemWithPlayerItem:avSong];
        [[CurrentSong currentSong].musicPlayer play];
    }
    
}

@end
