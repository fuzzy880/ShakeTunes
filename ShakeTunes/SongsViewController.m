//
//  SongsViewController.m
//  ShakeTunes
//
//  Created by Chris Wong on 10/19/13.
//  Copyright (c) 2013 Chris Wong. All rights reserved.
//

#import "SongsViewController.h"

@interface SongsViewController ()


@end

@implementation SongsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    [Jukebox shared].queue = [[everything items] mutableCopy];
    for (MPMediaItem *song in [Jukebox shared].queue) {
        NSLog(@"%@", [song valueForProperty:MPMediaItemPropertyTitle]);
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Loaded %lu songs from iPod Library", (unsigned long)[[Jukebox shared].queue count]);
    return [[Jukebox shared].queue count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"songCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    MPMediaItem *songItem = [[Jukebox shared].queue objectAtIndex:indexPath.row];
    cell.textLabel.text = [songItem valueForProperty:MPMediaItemPropertyTitle];
    cell.detailTextLabel.text = [songItem valueForProperty:MPMediaItemPropertyArtist];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [Jukebox shared].nowPlaying = indexPath.row;
    [Jukebox playSong];
}



@end
