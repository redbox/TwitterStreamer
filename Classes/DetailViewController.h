//
//  DetailViewController.h
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Twitter;
@class TwitterUser;

/**
 * Controller for detail view. Display twitter's status.
 **/
@interface DetailViewController : UIViewController {
	
	/** Label with text **/
	UILabel *textLabel;
	
	/** Label with date **/
	UILabel *dateLabel;
	
	/** Label woth username **/
	UILabel *userLabel;
	
	/** ImageView wich displays user's avatar **/
	UIImageView *avatarImageView;
	
	/** Twitter logo **/
	UIImageView *twitterImageView;
	
	/** Bottom line label **/
	UILabel *bottomLineLabel;
	
	/** Status to display **/
	Twitter *twitterStatus;
	
	/** User. Owner of the status **/
	TwitterUser *twitterUser;
}

/** Properties **/

@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *userLabel;
@property (nonatomic, retain) IBOutlet UILabel *bottomLineLabel;
@property (nonatomic, retain) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, retain) IBOutlet UIImageView *twitterImageView;

@property (nonatomic, retain) Twitter *twitterStatus;
@property (nonatomic, retain) TwitterUser *twitterUser;

/**
 * Setup target status and user to display.
 * @param status Target status
 * @param user Target user
 **/
- (void) setTwitterStatus: (Twitter *) status andUser: (TwitterUser *) user;

/**
 * Updates UI geometry depending on current info to displqy.
 **/
- (void) updateUI;

@end
