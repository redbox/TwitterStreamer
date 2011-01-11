//
//  TwitterXmlHelper.m
//  TwitterStreamer
//
//  Created by arty on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterUserBuilder.h"

#import "TwitterUser.h"
#import "Twitter.h"

#define NAME_TAG @"name"
#define SCREEN_NAME_TAG @"screen_name"
#define ID_TAG @"id"
#define IMAGE_TAG @"profile_image_url"

@implementation TwitterUserBuilder

-(TwitterUser *) newTwitterUserFromXml:(NSData *) xmlDocument {
	textBuffer = [[NSMutableString alloc] init];
	
	xmlParser = [[NSXMLParser alloc] initWithData: xmlDocument];
	[xmlParser setDelegate:self];
	[xmlParser setShouldResolveExternalEntities:YES];
	
	hasId = NO;
	user = [[TwitterUser alloc] init];
	[xmlParser parse];

	[textBuffer release];
	[xmlParser release];	
	return user;
}

-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI
  qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
	if ([elementName isEqualToString:NAME_TAG]
		|| [elementName isEqualToString:SCREEN_NAME_TAG]
		|| [elementName isEqualToString:ID_TAG]
		|| [elementName isEqualToString:IMAGE_TAG]) {
		elementFound = YES;
	}
}

-(void) parser:(NSXMLParser *) parser foundCharacters:(NSString *) string {
	if (elementFound) {
		[textBuffer appendString: string];
	}
}

-(void) parser:(NSXMLParser *) parser didEndElement:(NSString *) elementName
   namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName {
	if (elementFound) {
		elementFound = NO;
		NSString *value = [[NSString alloc] initWithString: textBuffer];		
		if ([elementName isEqualToString:NAME_TAG]) {
			user.name = value;
		} else if ([elementName isEqualToString:SCREEN_NAME_TAG]) {
			user.screenName = value;
		} else if ([elementName isEqualToString:ID_TAG]) {
			if (!hasId) { // ! Xml document has multiple tags with name 'id'
				hasId = YES;
				user.uid = [value integerValue];
			}
		} else if ([elementName isEqualToString:IMAGE_TAG]) {
			user.imageUrl = value;
		}
		[value release];
		[textBuffer setString:@""];
	}
}

-(void) dealloc {
	[super dealloc];
}

@end
