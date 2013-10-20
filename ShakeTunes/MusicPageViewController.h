//
//  MusicPageViewController.h
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NowPlayingViewController.h"

@interface MusicPageViewController : UIPageViewController <UIPageViewControllerDataSource>
{
    //id <NowPlayingDelegate> musicDelegate;
}

@property (nonatomic,assign)  id <NowPlayingDelegate> musicDelegate;

@end
