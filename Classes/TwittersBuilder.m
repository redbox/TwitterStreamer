//
//  TwittersBuilder.m
//  TwitterStreamer
//
//  Created by arty on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwittersBuilder.h"
#import "Twitter.h"

#define STATUS_TAG @"status"
#define ID_TAG @"id"
#define CREATED_AT_TAG @"created_at"
#define TEXT_TAG @"text"

@implementation TwittersBuilder

- (NSArray *) newTwittersFromXml:(NSData *) xmlDocument {
	textBuffer = [[NSMutableString alloc] init];
	
	xmlParser = [[NSXMLParser alloc] initWithData: xmlDocument];
	[xmlParser setDelegate:self];
	[xmlParser setShouldResolveExternalEntities:YES];
	
	listOfTwitters = [[NSMutableArray alloc] init];
	[xmlParser parse];
	
	[textBuffer release];
	[xmlParser release];	
	return listOfTwitters;
}

-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI
 qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
	if ([elementName isEqualToString:CREATED_AT_TAG]
		|| [elementName isEqualToString:ID_TAG]
		|| [elementName isEqualToString:TEXT_TAG]) {
		elementFound = YES;
	} else	if ([elementName isEqualToString:STATUS_TAG]) {
		hasId = NO;
		currentTwitter = [[Twitter alloc] init];
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
		if ([elementName isEqualToString:CREATED_AT_TAG]) {
			currentTwitter.createdAtSource = value;
		} else if ([elementName isEqualToString:ID_TAG]) {
			if (!hasId) { // ! Xml document has multiple tags with name 'id'
				hasId = YES;
				unsigned long long ullvalue = strtoull([value UTF8String], NULL, 0);
				NSNumber *number = [[NSNumber alloc] initWithLongLong: ullvalue];
				currentTwitter.uid = number;
				[number release];
			}
		} else if ([elementName isEqualToString:TEXT_TAG]) {
			currentTwitter.text = value;
		}
		[value release];
		[textBuffer setString:@""];
	} else if ([elementName isEqualToString:STATUS_TAG]) {
		[listOfTwitters addObject: currentTwitter];
	}
}

-(void) dealloc {
	[super dealloc];
}

@end