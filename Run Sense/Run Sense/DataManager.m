//
//  DataManager.m
//  REST_API
//
//  Created by Patrick Leopard II on 3/30/14.
//  Copyright (c) 2014 Patrick Leopard II. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

// Adds new user to database
// Input:  "name, "email", "password"
// Output: "user_id"
+ (NSDictionary *)addNewUser:(NSMutableDictionary *)data
{
    return [REST_API postPath:[kRootURL stringByAppendingString:kNewUser] data:[JSONConverter convertNSMutableDictionaryToJSON:data]];
}

// Sends database user ID and receives run ID in return
// Input:  "user_id"
// Output: "run_id"
+ (NSDictionary *)addNewRun
{
    return [REST_API postPath:[kRootURL stringByAppendingString:kNewRun] data:[JSONConverter convertNSMutableDictionaryToJSON:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]];
}

+ (NSDictionary *)addSteps:(NSMutableDictionary *)data
{
    return [REST_API postPath:[kRootURL stringByAppendingString:kAddSteps] data:[JSONConverter convertNSMutableDictionaryToJSON:data]];
}

@end