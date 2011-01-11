//
//  TwitterStatus.h
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwitterUser;

/**
 * Class is represening twitter's status model. Hass all needed data.
 **/
@interface Twitter : NSObject {
	/** Id **/
	NSNumber* uid;
	
	/** Owner's id **/
	NSInteger userId;
	
	/** Text content **/
	NSString *text;
	
	/** Indicates is status was created today **/
	BOOL isCreatedToday;
	
	/** Indicates is status was created yesterday **/
	BOOL isCreatedYersterday;
	
	/** Date of creation **/
	NSDate *date;
	
	/** Source string. It was Received from twitter's REST API **/
	NSString *createdAtSource;
	
	/** Creation date representation in format 'XX sec/min/hours ago' **/
	NSString *createdAtAsTimeAgo;
	
	/**  Creation date representation in format 'dd MMM HH:mm' **/
	NSString *createdAt;
}

/** Properties **/

@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic) NSInteger userId;
@property (nonatomic, retain) NSString *text;

@property (nonatomic) BOOL isCreatedToday;
@property (nonatomic) BOOL isCreatedYersterday;
@property (nonatomic, retain) NSString *createdAtSource;
@property (nonatomic, retain) NSString *createdAtAsTimeAgo;
@property (nonatomic, retain) NSString *createdAt;

/**
 * Updates and computes valid representation for creation date.
 * Updates createdAtAsTimeAgo and createdAt properties.
 **/
- (void) updateDatePresentation;

/**
 * Simple comparison depending on creation date.
 **/
- (NSInteger) compareTwitters:(Twitter *) anotherTwitter;

@end
