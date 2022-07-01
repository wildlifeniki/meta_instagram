//
//  DetailsViewController.m
//  Instagram
//
//  Created by Nikita Singh on 6/30/22.
//

#import "DetailsViewController.h"
#import "Post.h"
#import "DateTools.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPostObject:self.post];
    // Do any additional setup after loading the view.
}

- (void)setPostObject:(Post *)post {
    Post *newPost = [Post new];

    // get the current user and assign it to "author" field. "author" field is now of Pointer type
    newPost.author = [PFUser currentUser];
    
    _post = post;
    self.postImage.file = post[@"image"];
    [self.postImage loadInBackground];
    self.captionLabel.text = _post.caption;
    self.timeLabel.text = _post.createdAt.shortTimeAgoSinceNow;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
