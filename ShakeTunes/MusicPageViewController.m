//
//  MusicPageViewController.m
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "MusicPageViewController.h"

@interface MusicPageViewController ()

@end

@implementation MusicPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = self;
    NSArray *initViewController = @[[self. storyboard instantiateViewControllerWithIdentifier:@"NowPlaying"]];
    [self setViewControllers:initViewController direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[NowPlayingViewController class]]) {
        return nil;
    } else {
        return [self.storyboard instantiateViewControllerWithIdentifier:@"NowPlaying"];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[NowPlayingViewController class]]) {
        return [self.storyboard instantiateViewControllerWithIdentifier:@"MusicPicker"];
    } else {
        return nil;
    }
}

@end
