//
//  StockSoundsViewController.m
//  ShakeTunes
//
//  This view controller loads the included sounds in the projects into a table view.  Selecting
//  a row plays the song.
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "StockSoundsViewController.h"

@interface StockSoundsViewController ()

@property (strong, nonatomic) NSMutableArray *stockSounds;

@end

@implementation StockSoundsViewController


//Load the 3 stock songs from the project
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.stockSounds addObject:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test2" ofType:@"mp3"]]];
    [self.stockSounds addObject:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test3" ofType:@"mp3"]]];
    [self.stockSounds addObject:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test4" ofType:@"mp3"]]];
}


- (NSMutableArray *) stockSounds
{
    if (!_stockSounds) {
        _stockSounds = [[NSMutableArray alloc] init];
    }
    return _stockSounds;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.stockSounds count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"stockCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = [[self.stockSounds objectAtIndex:indexPath.row] lastPathComponent];
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [Jukebox shared].queue = self.stockSounds;
    [Jukebox shared].currentSong = indexPath.row;
    [Jukebox playSong];
}

@end
