//
//  CurrentSong.h
//  ShakeTunes
//
//  Model implements an API for music playback.  The queue provides the song context
//  and is set by the view controllers.
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface Jukebox : NSObject

@property NSInteger repeat;
@property NSInteger currentSong;
@property (strong, nonatomic) NSMutableArray  *queue;
@property (strong, nonatomic) AVAudioPlayer *musicPlayer;


/**
 * Get the shared singleton instance of music player
 */
+ (Jukebox *) shared;

/**
 * Get the current song's metadata information if from iOS music library
 */
+ (MPMediaItem *) getSongItem;

/**
 * Play the song in the queue at current index
 */
+ (void) playSong;

/**
 * Resume song from a pause
 */
+ (void) resumeSong;

/**
 * Pause currently playing song
 */
+ (void) pauseSong;

/**
 * Play next song
 */
+ (void) playNextSong;

/**
 * Play previous song
 */
+ (void) playPrevSong;

/**
 * Indicates if a song is playing
 */
+ (BOOL) isPlaying;

@end
