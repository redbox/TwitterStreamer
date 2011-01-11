//
//  TwitterUser.h
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TwitterUser : NSObject {
	NSInteger uid;
	NSString *name;
	NSString *screenName;
	NSString *imageUrl;
	UIImage *image;
}

@property (nonatomic) NSInteger uid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *screenName;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) UIImage *image;

- (TwitterUser *) initDefault;

@end
