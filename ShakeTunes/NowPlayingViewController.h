//
//  NowPlayingViewController.h
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "CurrentSong.h"
@interface NowPlayingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *currentAlbumArt;
@property (weak, nonatomic) IBOutlet UILabel *currentSongTitle;
@property (weak, nonatomic) IBOutlet UILabel *currentArtist;
@property (weak, nonatomic) IBOutlet UIProgressView *currentTrackProgress;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

- (IBAction)togglePlayPause:(id)sender;

@end
