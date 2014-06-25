//
//  LoginViewController.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 24/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "LoginViewController.h"
#import "CoreDataManager.h"
#import "UserEntity.h"
#import "TvShowsTableViewController.h"

@interface LoginViewController ()
@property (strong,nonatomic) CoreDataManager *coreDataManager;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;

@end

@implementation LoginViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _coreDataManager = [CoreDataManager sharedManager];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    UserEntity *user = [self loggedUser];
    if (user) {
        NSLog(@"Exists user");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TvShowsTableViewController *tvShowsVC = [storyboard instantiateViewControllerWithIdentifier:@"TvShowsVC"];
        
        [self.navigationController pushViewController:tvShowsVC animated:YES];
        tvShowsVC.title = [NSString stringWithFormat:@"Shows(%@)",user.userName];
    }
    NSLog(@"Last login: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"lastLogin"]);
}

- (UserEntity *)loggedUser{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([UserEntity class])];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"1=1"];
    NSError *error;
    NSArray *fetchResult=[self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResult.count?[fetchResult firstObject]:nil;
}


- (IBAction)loginPressed:(id)sender {
    UserEntity *user = [NSEntityDescription insertNewObjectForEntityForName:@"UserEntity"
                                                     inManagedObjectContext:self.coreDataManager.managedObjectContext];
    user.userId=@"1";
    user.userName=self.userName.text;
    user.userPassword = self.userPassword.text;
    NSError *error;
    [self.coreDataManager.managedObjectContext save:&error];
    if (!error) {
//        TvShowsTableViewController *tvShowsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TvShowsVC"];
//        [self.navigationController pushViewController:tvShowsVC animated:YES];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"lastLogin"];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    TvShowsTableViewController *tvShowsVC = [segue destinationViewController];
    tvShowsVC.title = [NSString stringWithFormat:@"Shows(%@)",self.userName.text];
}


@end
