//
//  TwittersBuilder.h
//  TwitterStreamer
//
//  Created by arty on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Twitter;

@interface TwittersBuilder : NSObject<NSXMLParserDelegate> {
	NSXMLParser *xmlParser;
	Twitter *currentTwitter;
	NSMutableArray *listOfTwitters;
	NSMutableString *textBuffer;
	BOOL elementFound;
	BOOL hasId;
}

- (NSArray *) newTwittersFromXml:(NSData *) xmlDocument;

@end
