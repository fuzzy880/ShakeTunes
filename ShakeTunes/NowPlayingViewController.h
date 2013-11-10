//
//  NowPlayingViewController.h
//  ShakeTunes
//
//  Implements functionality to update the Now Playing view with changes from Jukebox
//  and control the Jukebox with user input.
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Jukebox.h"
#include "NowPlayingDelegate.h"


@interface NowPlayingViewController : UIViewController <NowPlayingDelegate, AVAudioPlayerDelegate>
{
     NSTimer *songTimer;
}

@property (weak, nonatomic) IBOutlet UIImageView *currentAlbumArt;
@property (weak, nonatomic) IBOutlet UILabel *currentSongTitle;
@property (weak, nonatomic) IBOutlet UILabel *currentArtist;
@property (weak, nonatomic) IBOutlet UIProgressView *currentTrackProgress;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIImageView *albumArtBlurred;
@property (weak, nonatomic) IBOutlet UILabel *timeElasped;
@property (weak, nonatomic) IBOutlet UILabel *timeLeft;

- (IBAction)togglePlayPause;

@end
