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

-(void)setPostObject:(Post *)post {
    //self.postImage.image = self.post.image;

}


@end
