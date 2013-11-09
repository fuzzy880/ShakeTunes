//
//  MusicPageViewController.h
//  ShakeTunes
//
//  This view controller subclasses UIPageViewController to handle the navigation between
//  Now Playing and Music Navigator through left and right swipes.
//  Shake detection is handled and interfaces with music player based on number of shakes.
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
