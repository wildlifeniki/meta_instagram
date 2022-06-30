//
//  FeedViewController.m
//  Instagram
//
//  Created by Nikita Singh on 6/29/22.
//

#import "FeedViewController.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "InstaCell.h"
#import "ComposeViewController.h"

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrayOfPosts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end

@implementation FeedViewController

- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;

    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
    // PFUser.current() will now be nil
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    
    [self getFeed];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getFeed) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self getFeed];
    [self.tableView reloadData];
}

-(void)getFeed {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            NSLog(@"feed loaded successfully");
            for (Post *post in posts) {
                NSString *text = post.caption;
                NSLog(@"%@", text);
            }
            self.arrayOfPosts = [NSMutableArray arrayWithArray:posts];
            [self.tableView reloadData];
        } else {
            NSLog(@"feed loading failed: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];

    }];
    [self.refreshControl endRefreshing];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InstaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.post = post;
    [cell setPostObject:post];
    
    return cell;
}

//- (void)didPost:(Post *)post{
//    [self.arrayOfPosts insertObject:post atIndex:0];
//    [self.tableView reloadData];
//}

- (void)didPost {
    [self getFeed];
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}


@end
