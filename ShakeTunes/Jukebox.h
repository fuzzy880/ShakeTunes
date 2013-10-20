//
//  CurrentSong.h
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface Jukebox : NSObject

@property NSInteger nowPlaying;
@property (strong, nonatomic) NSMutableArray  *queue;
@property (strong, nonatomic) AVAudioPlayer *musicPlayer;
@property NSInteger repeat;

+ (Jukebox *) shared;

+ (MPMediaItem *) getSongItem;

+ (void) playSong;

+ (void) resumeSong;

+ (void) pauseSong;

+ (void) playNextSong;

+ (void) playPrevSong;

+ (BOOL) isPlaying;

@end
