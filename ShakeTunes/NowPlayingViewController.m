//
//  NowPlayingViewController.m
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "NowPlayingViewController.h"

@implementation NowPlayingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
    UIToolbar* blurView = [[UIToolbar alloc] initWithFrame:self.view.bounds];
    blurView.barStyle = UIBarStyleBlack;
    blurView.translucent = YES;
    [self.view insertSubview:blurView aboveSubview:self.albumArtBlurred];
    
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}


/**
 * Update the UI with current song details and update the state of music player controls
 */
- (void) updateUI
{
    self.currentSongTitle.text = [[Jukebox getSongItem] valueForProperty:MPMediaItemPropertyTitle];
    self.currentArtist.text = [[Jukebox getSongItem] valueForProperty:MPMediaItemPropertyArtist];
    MPMediaItemArtwork *albumArt = [[Jukebox getSongItem] valueForProperty:MPMediaItemPropertyArtwork];
    self.currentAlbumArt.image = [albumArt imageWithSize:CGSizeMake(320, 320)];
    self.albumArtBlurred.image = [albumArt imageWithSize:CGSizeMake(320, 320)];
    
    if ([Jukebox shared].musicPlayer) {
        [self.nextButton setEnabled:YES];
        [self.previousButton setEnabled:YES];
        [self.playPauseButton setEnabled:YES];
        
        if ([Jukebox isPlaying]) {
            [self updateSongProgress];
            [self.playPauseButton setImage:[UIImage imageNamed:@"pauseButton.png"] forState:UIControlStateNormal];
            [Jukebox shared].musicPlayer.delegate = self;
        } else {
            [self.playPauseButton setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        }
        
    } else {
        [self.playPauseButton setEnabled:NO];
        [self.nextButton setEnabled:NO];
        [self.previousButton setEnabled:NO];
        
    }
}


- (void) updateSongProgress
{
    if (![songTimer isValid]) {
        songTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(updateSongProgress) userInfo:nil repeats:YES];
    }
    NSInteger currentTimeInSeconds = [[Jukebox shared].musicPlayer currentTime];
    NSInteger totalTimeInSeconds = [[Jukebox shared].musicPlayer duration];
    NSString *currentFormattedTime = [NSString stringWithFormat:@"%d:%02d", currentTimeInSeconds/60, currentTimeInSeconds%60];
    NSString *totalFormattedTime = [NSString stringWithFormat:@"%d:%02d", (totalTimeInSeconds-currentTimeInSeconds)/60, (totalTimeInSeconds-currentTimeInSeconds)%60];
    
    [self.currentTrackProgress setProgress:((double)currentTimeInSeconds/(double)totalTimeInSeconds)];
    self.timeElasped.text = currentFormattedTime;
    self.timeLeft.text = totalFormattedTime;
    
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [songTimer invalidate];
    songTimer = nil;
    [self playNextSong];
}


- (IBAction)togglePlayPause
{
    if ([Jukebox isPlaying]) {
        [Jukebox pauseSong];
    } else {
        [Jukebox resumeSong];
    }
    [self updateUI];
    NSLog(@"[Song]: Toggling play/pause");

}

- (IBAction)playNextSong
{
    [Jukebox playNextSong];
    [self updateUI];
    NSLog(@"[Song]: Playing next song");

}

- (IBAction)playPreviousSong
{
    [Jukebox playPrevSong];
    [self updateUI];
    NSLog(@"[Song]: Playing previous song");

}

@end
