//
//  TvShowsTableViewController.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 23/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "TvShowsTableViewController.h"
#import "TVShow.h"


static NSString *savedShowsFileName = @"shows";

@interface TvShowsTableViewController ()
@property (strong, nonatomic) NSMutableArray *tvShows;

@end

@implementation TvShowsTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _tvShows = [NSMutableArray array];
        
        NSURL *jsonURL = [NSURL URLWithString:@"http://ironhack4thweek.s3.amazonaws.com/shows.json"];
        NSData *seriesData = [NSData dataWithContentsOfURL:jsonURL];
        NSError *error;
        
        NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:seriesData options:NSJSONReadingMutableContainers error:&error];
        
        for (NSDictionary* tvShowDictionary in [JSONDictionary valueForKey:@"shows"]) {
            NSError *parseError;
            TVShow *showItem = [MTLJSONAdapter modelOfClass:[TVShow class] fromJSONDictionary:tvShowDictionary error:&parseError];
            [self.tvShows addObject:showItem];
        }
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    [self loadShows];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.tvShows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showCell" forIndexPath:indexPath];
    TVShow *show = self.tvShows[indexPath.row];
    cell.textLabel.text = show.showTitle;
    // Configure the cell...
    
    return cell;
}


- (IBAction)addShow:(id)sender {
    [self.tvShows addObject:[self randomShow]];
    [self.tableView reloadData];
    
}

- (TVShow *)randomShow{
    TVShow *show = [[TVShow alloc] init];
    show.showTitle = [NSString stringWithFormat:@"Show %i", self.tvShows.count +1 ];
    show.showDescription = [NSString stringWithFormat: @"Great show %i", self.tvShows.count +1];
    show.showId = [NSString stringWithFormat:@"id %@",[NSDate dateWithTimeIntervalSinceNow:10]];
    show.showRating = arc4random()/10.0f;
    return show;
}

- (IBAction)copyShow:(id)sender {
    TVShow *show = [[self.tvShows lastObject] copy];
    [self.tvShows addObject: show];
    [self.tableView reloadData];
}

- (IBAction)saveShows:(id)sender {
    if (self.tvShows.count) {
        [NSKeyedArchiver archiveRootObject:self.tvShows toFile:[self archivePath]];
    }
}

- (void) loadShows{
    NSArray *shows = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    if (shows) {
        self.tvShows = [shows mutableCopy];
    }
}

- (NSString *)archivePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return [documentsDirectory stringByAppendingPathComponent:savedShowsFileName];
}
- (IBAction)compareShows:(id)sender {
    NSArray *selectedShows = [self.tableView indexPathsForSelectedRows];
    if (selectedShows.count == 2) {
        NSIndexPath* row1 = (NSIndexPath*)selectedShows[0];
        NSIndexPath* row2 = (NSIndexPath*)selectedShows[1];
        TVShow *show1 = self.tvShows[row1.row];
        TVShow *show2 = self.tvShows[row2.row];
        [show1 isEqual:show2];
    }
}
- (IBAction)containsShow:(id)sender {
    if ([self.tableView indexPathsForSelectedRows].count ==1) {
        NSIndexPath *indexSelected = [self.tableView indexPathForSelectedRow];
        TVShow *selectedShow = self.tvShows[indexSelected.row];
        if ([self.tvShows containsObject:selectedShow]) {
            NSLog(@"Contains it");
        }
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
