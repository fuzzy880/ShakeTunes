//
//  StockSoundsViewController.h
//  ShakeTunes
//
//  This view controller loads the included sounds in the projects into a table view.  Selecting
//  a row plays the song.
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Jukebox.h"

@interface StockSoundsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@end
