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

/**
 * Class for creating and configuring instance of TwitterUser class from XML document.
 **/
@interface TwitterUserBuilder : NSObject<NSXMLParserDelegate> {
	/** XML parser **/
	NSXMLParser *xmlParser;
	
	/** Used for storing target object of TwitterUser class **/
	TwitterUser *user;
	
	/** Text buffer **/
	NSMutableString *textBuffer;
	
	/** Indicates that target XML element was founded **/
	BOOL elementFound;
	
	/** Indicates that target object's of TwitterUser class 'uid' property already has configured **/	
	BOOL hasId;
}

/**
 * Creates new instance of TwitterUser class, according to XML document
 * @param xmlDocument Target XML document
 * @return new instance of TwitterUser class
 **/
- (TwitterUser *) newTwitterUserFromXml:(NSData *) xmlDocument;

@end
