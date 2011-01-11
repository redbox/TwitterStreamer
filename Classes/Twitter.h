//
//  TwitterStatus.h
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwitterUser;

@interface Twitter : NSObject {
	NSNumber* uid;
	NSInteger userId;
	NSString *text;
	
	BOOL isCreatedToday;
	BOOL isCreatedYersterday;
	NSDate *date;
	NSString *createdAtSource;
	NSString *createdAtAsTimeAgo;
	NSString *createdAt;
}

@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic) NSInteger userId;
@property (nonatomic, retain) NSString *text;

@property (nonatomic) BOOL isCreatedToday;
@property (nonatomic) BOOL isCreatedYersterday;
@property (nonatomic, retain) NSString *createdAtSource;
@property (nonatomic, retain) NSString *createdAtAsTimeAgo;
@property (nonatomic, retain) NSString *createdAt;


- (Twitter *) initDefault;
- (void) updateDatePresentation;
- (NSInteger) compareTwitters:(Twitter *) anotherTwitter;

@end
