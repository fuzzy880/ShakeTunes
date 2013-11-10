//
//  CurrentSong.m
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "Jukebox.h"

@implementation Jukebox

static Jukebox *currentSong = nil;

+ (Jukebox *) shared
{
    @synchronized(self) {
        if (!currentSong) {
            currentSong = [[Jukebox alloc] init];
            [Jukebox shared].repeat = 0;
            [Jukebox shared].nowPlaying = -1;
        }
    }
    return currentSong;
}


+ (MPMediaItem *) getSongItem
{
    if ([Jukebox shared].nowPlaying >= 0 && [Jukebox shared].nowPlaying < [[Jukebox shared].queue count]) {
        id selectedSongs = [[Jukebox shared].queue objectAtIndex:[Jukebox shared].nowPlaying];
        if (![selectedSongs isKindOfClass:[NSURL class]]) {
            return [selectedSongs representativeItem];
        }
    }
    return nil;
}


+ (void) playSong
{
    if ([Jukebox shared].nowPlaying >= 0 && [Jukebox shared].nowPlaying < [[Jukebox shared].queue count]) {
        NSError *error = nil;
        id selectedSongs = [[Jukebox shared].queue objectAtIndex:[Jukebox shared].nowPlaying];
        NSURL *songLocation = nil;
        //Playing project music files
        if ([selectedSongs isKindOfClass:[NSURL class]]) {
            songLocation = selectedSongs;
        //Playing iOS music library files
        } else {
            MPMediaItem *songItem = [selectedSongs representativeItem];
            songLocation = [songItem valueForProperty:MPMediaItemPropertyAssetURL];
        }
        [Jukebox shared].musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songLocation error:&error];
        [Jukebox shared].musicPlayer.numberOfLoops = [Jukebox shared].repeat;
        [[Jukebox shared].musicPlayer play];
    }
}


+ (void) resumeSong
{
    if ([Jukebox shared].musicPlayer) {
        [[Jukebox shared].musicPlayer play];
    }
    
}


+ (void) pauseSong
{
    [[Jukebox shared].musicPlayer pause];
}


+ (void) playNextSong
{
    if (([Jukebox shared].nowPlaying + 1) < [[Jukebox shared].queue count]) {
        [Jukebox shared].nowPlaying = [Jukebox shared].nowPlaying + 1;
        [Jukebox playSong];
    }
}


+ (void) playPrevSong
{
    if (([Jukebox shared].nowPlaying - 1) > -1) {
        [Jukebox shared].nowPlaying = [Jukebox shared].nowPlaying - 1;
        [Jukebox playSong];
    }
}


+ (BOOL) isPlaying
{
    return [[Jukebox shared].musicPlayer isPlaying];
}

@end
