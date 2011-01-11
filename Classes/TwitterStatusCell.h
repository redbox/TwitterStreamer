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

/**
 * Cell for representing twitter's status
 **/
@interface TwitterStatusCell : UITableViewCell {
	/* Image for profile's avatar */
	UIImageView *avatarImageView;
	
	/* Label for name */
	UILabel *nameLabel;
	
	/* Label for screen name */
	UILabel *screenLabel;
	
	/* Label for date presentation*/
	UILabel *dateLabel;	
	
	/* Label for twittter's status text */
	UILabel *textLabel;
}

/* Properties */
@property (nonatomic, retain) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *screenLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *textLabel;

/**
 * Setup target twiter's status and user, to display
 * @param twitterStatus Twitter's status to display
 * @param twitterUser Twitter user. Owner of targetstatuse.
 **/
- (void)setupWithTwitterStatus:(Twitter *)twitterStatus twitterUser:(TwitterUser *)twitterUser;

/**
 * Setup UI for cell accroding to twiter's status and user's information
 **/
- (void)setupUI;

@end