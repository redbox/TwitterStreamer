//
//  TwitterUser.h
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Class is representing twitter user model. Has all needed data.
 **/
@interface TwitterUser : NSObject {
	
	/** User's id **/
	NSInteger uid;
	
	/** User's name **/
	NSString *name;
	
	/** User's screen name **/
	NSString *screenName;
	
	/** Url of user's avatar **/
	NSString *imageUrl;
	
	/** User's avatar image **/
	UIImage *image;
}

/** Properties **/
@property (nonatomic) NSInteger uid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *screenName;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) UIImage *image;

@end
