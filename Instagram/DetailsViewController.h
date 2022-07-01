//
//  DetailsViewController.h
//  Instagram
//
//  Created by Nikita Singh on 6/30/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Post.h"
@import Parse;


NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Post *post;

@property (strong, nonatomic) IBOutlet PFImageView *postImage;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end

NS_ASSUME_NONNULL_END
