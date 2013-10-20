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
            [Jukebox shared].repeat = -1;
            [Jukebox shared].nowPlaying = -1;
        }
    }
    return currentSong;
}

+ (MPMediaItem *) getSongItem
{
    if ([Jukebox shared].nowPlaying) {
        if ([Jukebox shared].nowPlaying > 0 && [Jukebox shared].nowPlaying < [[Jukebox shared].queue count]) {
            MPMediaItemCollection *selectedSongs = [[Jukebox shared].queue objectAtIndex:[Jukebox shared].nowPlaying];
            return [selectedSongs representativeItem];
        }
    }
    return nil;
}

+ (void) playSong
{
    if ([Jukebox shared].nowPlaying) {
        if ([Jukebox shared].nowPlaying > 0 && [Jukebox shared].nowPlaying < [[Jukebox shared].queue count]) {
            NSError *error = nil;
            MPMediaItemCollection *selectedSongs = [[Jukebox shared].queue objectAtIndex:[Jukebox shared].nowPlaying];
            MPMediaItem *songItem = [selectedSongs representativeItem];
            NSURL *songLocation = [songItem valueForProperty:MPMediaItemPropertyAssetURL];
            [Jukebox shared].musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songLocation error:&error];
            NSLog(@"Error playing song %@", error);
            [Jukebox shared].musicPlayer.numberOfLoops = [Jukebox shared].repeat;
            [[Jukebox shared].musicPlayer play];
        }
    }
}

+ (void) resumeSong
{
    if ([Jukebox shared].nowPlaying) {
        if ([Jukebox shared].musicPlayer) {
            [[Jukebox shared].musicPlayer play];
        }
    }
    
}

+ (void) pauseSong
{
    [[Jukebox shared].musicPlayer pause];
}

+ (void) playNextSong
{
    NSLog(@"%d", ([Jukebox shared].nowPlaying + 1));
    NSLog(@"%d", [[Jukebox shared].queue count]);
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
    NSLog([[Jukebox shared].musicPlayer isPlaying] ? @"Yes" : @"No");
    return [[Jukebox shared].musicPlayer isPlaying];
}

@end
