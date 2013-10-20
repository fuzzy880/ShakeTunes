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
    self.currentSongTitle.text = [[CurrentSong currentSong].nowPlayingSong valueForProperty:MPMediaItemPropertyTitle];
    self.currentArtist.text = [[CurrentSong currentSong].nowPlayingSong valueForProperty:MPMediaItemPropertyArtist];
    MPMediaItemArtwork *albumArt = [[CurrentSong currentSong].nowPlayingSong valueForProperty:MPMediaItemPropertyArtwork];
    self.currentAlbumArt.image = [albumArt imageWithSize:CGSizeMake(320, 320)];
    
    if ([CurrentSong currentSong].musicPlayer) {
        [self.playPauseButton setEnabled:YES];
        if ([CurrentSong isPlaying]) {
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
    NSLog(@"%@", [[CurrentSong currentSong].nowPlayingSong valueForProperty:MPMediaItemPropertyTitle]);
}

- (IBAction)togglePlayPause:(UIButton *)sender {
    if ([CurrentSong isPlaying]) {
        [CurrentSong pauseSong];
    } else {
        [CurrentSong resumeSong];
    }
    [self updateUI];
    
}


@end
