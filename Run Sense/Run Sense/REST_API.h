//
//  REST_API.h
//  REST_API
//
//  Created by Patrick Leopard II on 3/25/14.
//  Copyright (c) 2014 Patrick Leopard II. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONConverter.h"

@interface REST_API : NSObject

+ (NSDictionary*)getPath:(NSString*)resource;
+ (NSDictionary *)postPath:(NSString*)resource data:(NSString*)dataString;
+ (NSDictionary *)putPath:(NSString*)resource data:(NSString*)dataString;
+ (bool)testConnection:(NSString*)resource;

@end
