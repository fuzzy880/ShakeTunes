//
//  SongsViewController.h
//  ShakeTunes
//
//  Implements the All Songs tab.  On load, the iOS media library is
//  queried and displayed in a table.  Selecting a row plays the song.
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#include "Jukebox.h"

@interface SongsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@end
