//
//  NowPlayingViewController.h
//  ShakeTunes
//
//  This view controller implements functionality to update the view with changes from Jukebox.
//  In addition, buttons on the view will invoke actions to change the song.
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Jukebox.h"
#include "NowPlayingDelegate.h"


@interface NowPlayingViewController : UIViewController <NowPlayingDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *albumArtBlurred;

- (IBAction)togglePlayPause:(id)sender;

@end
