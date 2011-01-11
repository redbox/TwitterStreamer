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

/**
 * Controller for list view. Display twitter statuses. 
 **/
@interface ListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, TwitterCollectionDelegate> {	
	
	/** Target twitter user's name **/
	NSString *twitterUserName;
	
	/** Twitter's statuses storage **/
	TwitterCollection *twitterCollection;
	
    // UI 
	/** Navigation back button **/
	UIBarButtonItem *backButton;
	
	/** Controller for managing details view  **/	
	DetailViewController *detailViewController;
	
	/** List of statuses view **/
	UITableView *twittersView;
	
	/** View wich contains activity indicator **/
	UIView *loadingView;
}

/** Properties **/
 
@property (nonatomic, retain) NSString *twitterUserName;
@property (nonatomic, retain) TwitterUser *twitterUser;

@property (nonatomic, retain) IBOutlet UITableView *twitterView;
@property (nonatomic, retain) IBOutlet UIView *loadingView;

/**
 * Loads settings from global IPhone settings.
 **/
- (void) loadSettings;

@end
