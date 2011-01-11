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

@interface DetailViewController : UIViewController {
	UILabel *textLabel;
	UILabel *dateLabel;
	UILabel *userLabel;
	UIImageView *avatarImageView;
	UIImageView *twitterImageView;
	UILabel *bottomLineLabel;
	Twitter *twitterStatus;
	TwitterUser *twitterUser;
}

@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *userLabel;
@property (nonatomic, retain) IBOutlet UILabel *bottomLineLabel;
@property (nonatomic, retain) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, retain) IBOutlet UIImageView *twitterImageView;

@property (nonatomic, retain) Twitter *twitterStatus;
@property (nonatomic, retain) TwitterUser *twitterUser;

- (void) setTwitterStatus: (Twitter *) status andUser: (TwitterUser *) user;
- (void) updateUI;

@end
