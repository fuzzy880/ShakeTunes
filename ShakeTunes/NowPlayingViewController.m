//
//  NowPlayingViewController.m
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "NowPlayingViewController.h"

@interface NowPlayingViewController ()

@end

@implementation NowPlayingViewController

- (void) updateUI
{
    self.currentSongTitle.text = [[Jukebox getSongItem] valueForProperty:MPMediaItemPropertyTitle];
    self.currentArtist.text = [[Jukebox getSongItem] valueForProperty:MPMediaItemPropertyArtist];
    MPMediaItemArtwork *albumArt = [[Jukebox getSongItem] valueForProperty:MPMediaItemPropertyArtwork];
    self.currentAlbumArt.image = [albumArt imageWithSize:CGSizeMake(320, 320)];
    
    if ([Jukebox shared].musicPlayer) {
        [self.playPauseButton setEnabled:YES];
        if ([Jukebox isPlaying]) {
            [self.playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        } else {
            [self.playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
        }
    } else {
        [self.playPauseButton setTitle:@"Play" forState:UIControlStateDisabled];
        [self.playPauseButton setEnabled:NO];
    }
    
    NSLog(@"%@", self.playPauseButton.titleLabel.text);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (void) viewWillAppear:(BOOL)animated {
    [self updateUI];
    NSLog(@"%@", [[Jukebox getSongItem] valueForProperty:MPMediaItemPropertyTitle]);
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
    NSLog(@"Playing the next song");
    [Jukebox playNextSong];
    [self updateUI];
}

- (IBAction)playPreviousSong:(id)sender {
    [Jukebox playPrevSong];
    [self updateUI];
}


@end
