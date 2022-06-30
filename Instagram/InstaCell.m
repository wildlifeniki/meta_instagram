//
//  InstaCell.m
//  Instagram
//
//  Created by Nikita Singh on 6/29/22.
//

#import "InstaCell.h"
#import "Post.h"

@implementation InstaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPostObject:(Post *)post {
    Post *newPost = [Post new];

    // get the current user and assign it to "author" field. "author" field is now of Pointer type
    newPost.author = [PFUser currentUser];
    
    _post = post;
    self.postImage.file = post[@"image"];
    [self.postImage loadInBackground];
    self.captionLabel.text = _post.caption;
}

@end
