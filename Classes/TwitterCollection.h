//
//  TwitterStatusCollection.h
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TwitterService.h"
#import "CacheHelper.h"

@class TwitterUser;
@class Twitter;

/**
 * Delegate is used to notification about progress of current update.
 */
@protocol TwitterCollectionDelegate<NSObject> 
@required
/**
 * Update was started
 **/
- (void) updateStarted;

/**
 * Update was finished
 */
- (void) updateStopped;
@end

/**
 * This class contains list of all twitter's statuses, and it is responsible for twitters's statuses management.
 * When loadAvailableTwitters, updateNewTwitters or updateOldTwitters is invoked, specified delegate receives notifications.
 * @see TwitterCollectionDelegate
 **/
@interface TwitterCollection : NSObject<TwitterServiceDelegate, CacheHelperDelegate> {
	
	/** Helper for managing Twitter REST API*/
	TwitterService *service;
	
	/** Helper for managing cache **/
	CacheHelper *cacheHelper;
	
	/** Twitter collection's delegate **/
	id <TwitterCollectionDelegate> delegate;
	
	// User related data //
	
	/** Twitter's user name to work with **/
	NSString *userName;
	
	/** For representing twitter's user as model **/
	TwitterUser *twitterUser;
	
	/** Image to display as user's avatar **/
	UIImage *userAvatar;

	// Twitters related data //
	
	/** List of twitters which was added today **/
	NSMutableArray *todaysTwitters;
	
	/** List of twitters which was added yesterday **/	
	NSMutableArray *yesterdayTwitters;
	
	/** List of twitters which was added early **/	
	NSMutableArray *earlyTwitters;	
	
	/** Id of newest status **/
	unsigned long long lastTwitterId;
	
	/** Id of oldest status **/	
	unsigned long long firstTwitterId;
}

/** Properties **/

@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) TwitterUser *twitterUser;
@property (nonatomic, retain) id delegate;

/**
 * Initialize instance with target delegate
 * @param delegate TwitterCollectionDelegate
 * @return Initialized instance 
 **/
- (TwitterCollection *) initWithUserName: (NSString *) userName delegate: (id<TwitterCollectionDelegate>) delegate;

/**
 * Load from server 30 recent twitter's statuses
 **/
- (void) loadAvailableTwitters;

/**
 * Load from server 30 recent twitter's statuses, which are not already loaded.
 **/
- (void) updateNewTwitters;

/**
 * Load from server 30 oldest twitter's statuses.
 **/
- (void) updateOldTwitters;

/**
 * Return total twittter's statuses count
 */
- (NSInteger) totalCount;

/**
 * Return total twittter's statuses count, which was added today
 */
- (NSInteger) countTodayCreatedTwitters;

/**
 * Return total twittter's statuses count, which was added yesterday
 */
- (NSInteger) countYesterdayCreatedTwitters;

/**
 * Return total twittter's statuses count, which was added early
 */
- (NSInteger) countEarlierCreatedTwitters;

/**
 * Return twittter's status, which was added today, by zero based index
 */
- (Twitter *) todayTwitterByIndex: (NSInteger) index;

/**
 * Return twittter's status, which was added yesterday, by zero based index
 */
- (Twitter *) yesterdayTwitterByIndex: (NSInteger) index;

/**
 * Return twittter's status, which was added early, by zero based index
 */
- (Twitter *) earlierTwitterByIndex: (NSInteger) index;

@end
