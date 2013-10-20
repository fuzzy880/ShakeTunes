//
//  CurrentSong.h
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CurrentSong : NSObject

@property (strong, nonatomic) MPMediaItem *nowPlayingSong;

+ (CurrentSong *) currentSong;

@end
