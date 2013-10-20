//
//  SongsViewController.m
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "SongsViewController.h"

@interface SongsViewController ()

@property (strong, nonatomic) NSMutableArray *songsList;

@end

@implementation SongsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    self.songsList = [[everything items] mutableCopy];
    for (MPMediaItem *song in self.songsList) {
        NSLog(@"%@", [song valueForProperty:MPMediaItemPropertyTitle]);
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Loaded %d songs from iPod Library", [self.songsList count]);
    return [self.songsList count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"songCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    MPMediaItem *songItem = [self.songsList objectAtIndex:indexPath.row];
    cell.textLabel.text = [songItem valueForProperty:MPMediaItemPropertyTitle];
    cell.detailTextLabel.text = [songItem valueForProperty:MPMediaItemPropertyArtist];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPMediaItemCollection *selectedSongs = [self.songsList objectAtIndex:indexPath.row];
    MPMediaItem *songItem = [selectedSongs representativeItem];
    [CurrentSong currentSong].nowPlayingSong = songItem;
    NSLog(@"Now playing song is %@", [songItem valueForProperty:MPMediaItemPropertyTitle]);
    [CurrentSong playSong];
}



@end
