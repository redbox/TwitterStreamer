//
//  RootViewController.h
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//view-source:http://api.twitter.com/1/users/show/flatsoft.xml
//view-source:http://api.twitter.com/1/statuses/user_timeline.xml?user_id=59402420&trim_user=true

#import <UIKit/UIKit.h>

#import "TwitterCollection.h"

@class TwitterUser;
@class TwitterCollection;
@class DetailViewController;

@interface RootViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, TwitterCollectionDelegate> {	
	// Twitter related data
	NSString *twitterUserName;
	TwitterCollection *twitterCollection;
	
	// UI
	UIBarButtonItem *backButton;
	DetailViewController *detailViewController;
	UITableView *twittersView;
	UIView *loadingView;
}

@property (nonatomic, retain) NSString *twitterUserName;
@property (nonatomic, retain) TwitterUser *twitterUser;

@property (nonatomic, retain) IBOutlet UITableView *twitterView;
@property (nonatomic, retain) IBOutlet UIView *loadingView;

// Logic and service
- (void) loadSettings;
- (Twitter *) twitterByIndexPath: (NSIndexPath *) indexPath;

@end
