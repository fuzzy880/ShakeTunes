//
//  SongsViewController.m
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "SongsViewController.h"

@interface SongsViewController ()

@property (strong, nonatomic) NSMutableArray *allSongs;

@end

@implementation SongsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    self.allSongs = [[everything items] mutableCopy];
}


- (NSMutableArray *) allSongs
{
    if (!_allSongs) {
        _allSongs = [[NSMutableArray alloc] init];
    }
    return _allSongs;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allSongs count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"songCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    MPMediaItem *songItem = [self.allSongs objectAtIndex:indexPath.row];
    cell.textLabel.text = [songItem valueForProperty:MPMediaItemPropertyTitle];
    cell.detailTextLabel.text = [songItem valueForProperty:MPMediaItemPropertyArtist];
    
    UIImage *albumArt = [[songItem valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(30, 30)];
    if (albumArt) {
        cell.imageView.image = albumArt;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"noArt.png"];
    }
   
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [Jukebox shared].queue = self.allSongs;
    [Jukebox shared].currentSong = indexPath.row;
    [Jukebox playSong];
}

@end
