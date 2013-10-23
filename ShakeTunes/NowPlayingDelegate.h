//
//  NowPlayingDelegate.h
//  ShakeTunes
//
//  Protocol that enforces the delegates class's ability to update the Now Playing UI
//
//  Created by Chris Wong on 10/20/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NowPlayingDelegate

- (void) updateUI;

@end
