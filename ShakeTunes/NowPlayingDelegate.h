//
//  NowPlayingDelegate.h
//  ShakeTunes
//
//  Protocol that enforces the delegate's ability to update the Now Playing UI
//
//  Created by Chris Wong on 10/20/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NowPlayingDelegate


/**
 * Sync the Now Playing UI with Jukebox model
 */
- (void) updateUI;

@end
