//
//  TwitterStatusCell.h
//  TwitterStreamer
//
//  Created by arty on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Twitter;
@class TwitterUser;

@interface TwitterStatusCell : UITableViewCell {
	UIImageView *avatarImageView;
	UILabel *nameLabel;
	UILabel *screenLabel;
	UILabel *dateLabel;	
	UILabel *textLabel;
}

@property (nonatomic, retain) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *screenLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *textLabel;

- (void)setupWithTwitterStatus:(Twitter *)twitterStatus twitterUser:(TwitterUser *)twitterUser;
- (void)setupUI;

@end