//
//  MusicPageViewController.m
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "MusicPageViewController.h"

@interface MusicPageViewController ()

@property (nonatomic) NSUInteger shakesDetected;

@end

@implementation MusicPageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = self;
    id nowPlayingController = [self. storyboard instantiateViewControllerWithIdentifier:@"NowPlaying"];
    self.musicDelegate = nowPlayingController;

    NSArray *initViewController = @[nowPlayingController];
    [self setViewControllers:initViewController direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}


- (void) viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}


/**
 * Sets NowPlayingViewController before MusicPickerTabViewController
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[NowPlayingViewController class]]) {
        return nil;
    } else {
        return [self.storyboard instantiateViewControllerWithIdentifier:@"NowPlaying"];
    }
}


/*
 * Sets MusicPickerTabViewController after NowPlayingViewController
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[NowPlayingViewController class]]) {
        return [self.storyboard instantiateViewControllerWithIdentifier:@"MusicPicker"];
    } else {
        return nil;
    }
}


- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"[MotionEvent]: Detected shake event");
        if (self.shakesDetected == 0) {
            self.shakesDetected = 1;
            shakeTimer = [NSTimer scheduledTimerWithTimeInterval:.75 target:self selector:@selector(interpretShakes) userInfo:nil repeats:NO];
        } else if (self.shakesDetected >= 1) {
            self.shakesDetected++;
        }
    }
}


/**
 * Called by shakeTimer to translate # of shakes to music action
 */
- (void) interpretShakes
{
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    
    if (self.shakesDetected >= 2) {
        [self nextSong];
    } else if (self.shakesDetected == 1) {
        [self pausePlaySong];
    }
    
    [shakeTimer invalidate];
    shakeTimer = nil;
    
    self.shakesDetected = 0;
}


- (void) pausePlaySong
{
    if ([Jukebox isPlaying]) {
        [Jukebox pauseSong];
    } else {
        [Jukebox resumeSong];
    }
    
    [self.musicDelegate updateUI];
    NSLog(@"[MotionEvent]: 1 shake detected -> toggling play/pause");
}


- (void) nextSong
{
    [Jukebox playNextSong];
    [self.musicDelegate updateUI];
    NSLog(@"[MotionEvent]: 2 shakes detected -> playing next song");

}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}


- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
