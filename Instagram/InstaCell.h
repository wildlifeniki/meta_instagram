//
//  InstaCell.h
//  Instagram
//
//  Created by Nikita Singh on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface InstaCell : UITableViewCell

@property (strong, nonatomic) Post *post;

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
//@property (strong, nonatomic) IBOutlet UIImageView *postImage;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet PFImageView *postImage;


-(void)setPostObject:(Post *)post;

@end

NS_ASSUME_NONNULL_END
