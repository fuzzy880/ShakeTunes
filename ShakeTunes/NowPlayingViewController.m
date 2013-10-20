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
    NSString *songTitle = [[CurrentSong currentSong].nowPlayingSong valueForProperty:MPMediaItemPropertyTitle];
    if (songTitle) {
        self.currentSongTitle.text = songTitle;
    }
    NSString *songArtist = [[CurrentSong currentSong].nowPlayingSong valueForProperty:MPMediaItemPropertyArtist];
    if (songArtist) {
        self.currentArtist.text = songArtist;
    }
    MPMediaItemArtwork *albumArt = [[CurrentSong currentSong].nowPlayingSong valueForProperty:MPMediaItemPropertyArtwork];
    if (albumArt) {
        self.currentAlbumArt.image = [albumArt imageWithSize:CGSizeMake(320, 320)];
    }
    
    NSLog(@"%@", songTitle);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [self updateUI];
    NSLog(@"%@", [[CurrentSong currentSong].nowPlayingSong valueForProperty:MPMediaItemPropertyTitle]);
}

- (IBAction)togglePlayPause:(id)sender {
}
@end
