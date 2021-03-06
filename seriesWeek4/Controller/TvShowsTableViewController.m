//
//  TvShowsTableViewController.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 23/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "TvShowsTableViewController.h"
#import "TVShow.h"
#import "CoreDataManager.h"
#import "UserEntity.h"
#import "ShowDetailViewController.h"
#import "ShowsProvider.h"
#import "UIImageView+Shows.h"


static NSString *savedShowsFileName = @"shows";

@interface TvShowsTableViewController () <ShowDetailDelegate>
@property (strong, nonatomic) NSMutableArray *tvShows;
@property (strong, nonatomic) CoreDataManager *coreDataManager;
@property (strong, nonatomic) NSMutableArray *showsLikes;
@property (strong, nonatomic) ShowsProvider *showsProvider;

@end

@implementation TvShowsTableViewController

- (void)loadDataFromAFN {
    @weakify(self); //No es necesario aquí, no se produce un retain cycle ya que el success block no es retenido en la función de showsProvider. Pero si lo tenemos es inocuo.
    [self.showsProvider getListOfShowsWithSuccessBlock:^(NSMutableArray *shows) {
        @strongify(self);
        self.tvShows = shows;
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.tableView reloadData];
        });
    } errorBlock:^(NSError * error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error in request" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alertView show];
    }];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        _tvShows = [NSMutableArray array];
        _showsProvider = [[ShowsProvider alloc] init];
        _coreDataManager = [CoreDataManager sharedManager];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *userName = [self loggedUser].userName;
    [self logFileAttributes];
    self.showsLikes = [self loadShowsLikes:userName];
    [self loadDataFromAFN];
//    [self loadShows];
    
}

- (void)logFileAttributes{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsPath error:nil];
    for (NSString *path in contents) {
        NSString *filePath = [documentsPath stringByAppendingPathComponent:path];
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:filePath error:nil];
        NSLog(@"%@",attributes);
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    //Save info in plist
    NSString *userName = [self loggedUser].userName;
    [self saveShowsLikes:userName];
}

- (UserEntity *)loggedUser{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([UserEntity class])];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"1=1"];
    NSError *error;
    NSArray *fetchResult=[self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResult.count?[fetchResult firstObject]:nil;
}

- (NSMutableArray *)showsLikes{
    if (!_showsLikes) {
        _showsLikes = [[NSMutableArray alloc] init];
    }
    return _showsLikes;
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
    
    // Configure the cell... Mejor hacerlo con cell custom ya que la carga de imagen no va bien al principio.
    cell.imageView.image = [UIImage imageNamed:@"first"];
    ///main thread
    [cell.imageView setImageWithURL:[NSURL URLWithString:show.posterURL] completion:^(BOOL success) {
        
    }];
    
    
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

- (IBAction)logoutPressed:(id)sender {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserEntity"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"1=1"];
    NSError *error;
    NSArray *fetchResult=[self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    UserEntity *user = fetchResult.count?[fetchResult firstObject]:nil;
    [self removeLikesFile:user.userName];
    [self.coreDataManager.managedObjectContext deleteObject:user];
    NSError *errorDelete;
    [self.coreDataManager.managedObjectContext save:&errorDelete];
    if (!error) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void) removeLikesFile:(NSString *)userName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistFilePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-likes.plist",userName]];
    NSError *error = nil;
    if (![fileManager removeItemAtPath:plistFilePath error:&error]) {
        NSLog(@"[Error] %@ (%@)", error, plistFilePath);
    }
}

- (NSMutableArray *)loadShowsLikes:(NSString *)userName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistFilePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-likes.plist",userName]];
    BOOL fileExists = [fileManager fileExistsAtPath:plistFilePath];
    NSDictionary *showsLikes;
    if (!fileExists) {
        showsLikes = [[NSDictionary alloc] init];
    } else{
        showsLikes = [NSDictionary dictionaryWithContentsOfFile:plistFilePath];
    }
    
    return [(NSArray *)[showsLikes objectForKey:@"likes"] mutableCopy];
}

- (void)saveShowsLikes:(NSString *)userName
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistFilePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-likes.plist",userName]];
    NSDictionary *likes = @{@"likes": self.showsLikes};
    [likes writeToFile:plistFilePath atomically:YES];
}

#pragma mark - Delegation

- (void)like{
    NSInteger selectedIndex = [self.tableView indexPathForSelectedRow].row;
    [self.showsLikes addObject:[NSNumber numberWithInt:selectedIndex]];
}

- (void)dislike {
    NSInteger selectedIndex = [self.tableView indexPathForSelectedRow].row;
    [self.showsLikes addObject:[NSNumber numberWithInt:selectedIndex]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ShowDetailViewController *detailVC = [segue destinationViewController];
    NSInteger selectedIndex = [self.tableView indexPathForSelectedRow].row;
    TVShow *selectedShow = self.tvShows[selectedIndex];
    detailVC.title = selectedShow.showTitle;
    detailVC.tvShow = self.tvShows[selectedIndex];
    detailVC.delegate = self;
    if ([self.showsLikes containsObject:[NSNumber numberWithInt:selectedIndex]]) {
        detailVC.like = YES;
    }
    
}


@end
