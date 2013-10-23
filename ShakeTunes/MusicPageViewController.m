//
//  MusicPageViewController.m
//  ShakeTunes
//
//  This view controller subclasses UIPageViewController to handle the navigation between
//  Now Playing and Music Navigator through left and right swipes.
//  Shake detection is handled and interfaces with music player based on number of shakes.
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "MusicPageViewController.h"

@interface MusicPageViewController ()

@property (nonatomic) NSUInteger shakesDetected;

@end

@implementation MusicPageViewController

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

//Set datasource as the PageViewController, NowPlayingViewController as the delegate, and initial view controller
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

//Sets NowPlayingViewController before MusicPickerTabViewController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[NowPlayingViewController class]]) {
        return nil;
    } else {
        return [self.storyboard instantiateViewControllerWithIdentifier:@"NowPlaying"];
    }
}

//Sets MusicPickerTabViewController after NowPlayingViewController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[NowPlayingViewController class]]) {
        return [self.storyboard instantiateViewControllerWithIdentifier:@"MusicPicker"];
    } else {
        return nil;
    }
}

//Intreprets 1 shake in 1 second as a play/pause toggle and 2 shakes in 1 second as next song
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"Received shake event");
        if (self.shakesDetected == 0) {
            self.shakesDetected = 1;
            shakeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(interpretShakes) userInfo:nil repeats:NO];
        } else if (self.shakesDetected >= 1) {
            self.shakesDetected++;
        }
    }
}

//Called by shakeTimer to translate # of shakes to music action
- (void) interpretShakes
{
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
    NSLog(@"1 shake detected -> Toggling play/pause");
}

- (void) nextSong
{
    [Jukebox playNextSong];
    [self.musicDelegate updateUI];
    NSLog(@"2 shakes detected -> Playing next song");

}

@end
