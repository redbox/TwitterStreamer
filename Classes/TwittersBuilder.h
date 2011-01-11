//
//  TwittersBuilder.h
//  TwitterStreamer
//
//  Created by arty on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Twitter;

/**
 * Class for creating and configuring twitter's statuses from XML document.
 * Because one XML document contains multiple statuses, collection with statuses will be contstructed.
 **/
@interface TwittersBuilder : NSObject<NSXMLParserDelegate> {
	
	/** XML parser **/	
	NSXMLParser *xmlParser;
	
	/** Used for storing current object of Twitter class **/	
	Twitter *currentTwitter;
	
	/** List of twitter's statuses from XML document **/
	NSMutableArray *listOfTwitters;
	
	/** Text buffer **/	
	NSMutableString *textBuffer;
	
	/** Indicates that target XML element was founded **/	
	BOOL elementFound;
	
	/** Indicates that target object's of Twitter class 'uid' property already has configured **/		
	BOOL hasId;
}

/**
 * Creates new instances twitter's statuses from XML document.
 * Because one XML document contains multiple statuses, NSArray with statuses will be returned.
 * @param xmlDocument Target XML document
 * @return Array of statuses
 **/
- (NSArray *) newTwittersFromXml:(NSData *) xmlDocument;

@end
