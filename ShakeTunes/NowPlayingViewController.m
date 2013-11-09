//
//  NowPlayingViewController.m
//  ShakeTunes
//
//  This view controller implements functionality to update the view with changes from Jukebox.
//  In addition, buttons on the view will invoke actions to change the song.
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "NowPlayingViewController.h"

@interface NowPlayingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *currentAlbumArt;
@property (weak, nonatomic) IBOutlet UILabel *currentSongTitle;
@property (weak, nonatomic) IBOutlet UILabel *currentArtist;
@property (weak, nonatomic) IBOutlet UIProgressView *currentTrackProgress;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@end

@implementation NowPlayingViewController

//Update song details and play/pause button
- (void) updateUI
{
    self.currentSongTitle.text = [[Jukebox getSongItem] valueForProperty:MPMediaItemPropertyTitle];
    self.currentArtist.text = [[Jukebox getSongItem] valueForProperty:MPMediaItemPropertyArtist];
    MPMediaItemArtwork *albumArt = [[Jukebox getSongItem] valueForProperty:MPMediaItemPropertyArtwork];
    self.currentAlbumArt.image = [albumArt imageWithSize:CGSizeMake(320, 320)];
    self.albumArtBlurred.image = [albumArt imageWithSize:CGSizeMake(320, 320)];
    if ([Jukebox shared].musicPlayer) {
        [self.playPauseButton setEnabled:YES];
        if ([Jukebox isPlaying]) {
            [self.playPauseButton setTitle:@"Playing" forState:UIControlStateNormal];
        } else {
            [self.playPauseButton setTitle:@"Paused" forState:UIControlStateNormal];
        }
    } else {
        [self.playPauseButton setTitle:@"" forState:UIControlStateDisabled];
        [self.playPauseButton setEnabled:NO];
    }
    NSLog(@"UpdateUI: Play Button set to %@", self.playPauseButton.titleLabel.text);
}

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


- (IBAction)togglePlayPause:(UIButton *)sender {
    if ([Jukebox isPlaying]) {
        [Jukebox pauseSong];
    } else {
        [Jukebox resumeSong];
    }
    [self updateUI];
}

- (IBAction)playNextSong:(id)sender {
    [Jukebox playNextSong];
    [self updateUI];
}

- (IBAction)playPreviousSong:(id)sender {
    [Jukebox playPrevSong];
    [self updateUI];
}


@end
