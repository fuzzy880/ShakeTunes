//
//  MusicPageViewController.h
//  ShakeTunes
//
//  Subclasses: UIPageViewController to handle swipe navigation between Now Playing to
//              Music Picker
//
//  Handles the initiation of child view controllers.  Implements shake detection that
//  controls the music player based on number of shakes.
//
//  1 shake: play/pause song
//  2 shakes: next song
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "NowPlayingViewController.h"

@interface MusicPageViewController : UIPageViewController <UIPageViewControllerDataSource>
{
    NSTimer *shakeTimer;
}

@property (nonatomic,assign)  id <NowPlayingDelegate> musicDelegate;

@end
