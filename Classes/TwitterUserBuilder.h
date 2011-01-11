//
//  TwitterXmlHelper.h
//  TwitterStreamer
//
//  Created by arty on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwitterUser;
@class Twitter;

@interface TwitterUserBuilder : NSObject<NSXMLParserDelegate> {
	NSXMLParser *xmlParser;
	TwitterUser *user;
	NSMutableString *textBuffer;
	BOOL elementFound;
	BOOL hasId;
}

- (TwitterUser *) newTwitterUserFromXml:(NSData *) xmlDocument;

@end
