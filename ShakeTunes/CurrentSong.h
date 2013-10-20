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

@interface CurrentSong : NSObject

@property (strong, nonatomic) MPMediaItem *nowPlayingSong;
@property (strong, nonatomic) AVAudioPlayer *musicPlayer;
@property NSInteger repeat;

+ (CurrentSong *) currentSong;

+ (void) playSong;

+ (void) resumeSong;

+ (void) pauseSong;

+ (BOOL) isPlaying;

@end
