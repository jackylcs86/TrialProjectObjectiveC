//
//  SimInfo.m
//  TrialLibPhoneNumber
//
//  Created by weeclicks on 07/12/2017.
//  Copyright © 2017 weeclicks. All rights reserved.
//

#import "WCSimInfo.h"

@implementation WCSimInfo
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.countryCode = [aDecoder decodeObjectForKey:@"countryCode"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.isoCode = [aDecoder decodeObjectForKey:@"isoCode"];
        self.networkCode = [aDecoder decodeObjectForKey:@"networkCode"];
        self.isSupportVOIP = [aDecoder decodeBoolForKey:@"isSupportVOIP"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.countryCode forKey:@"countryCode"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.isoCode forKey:@"isoCode"];
    [aCoder encodeObject:self.networkCode forKey:@"networkCode"];
    [aCoder encodeBool:self.isSupportVOIP forKey:@"isSupportVOIP"];
}
@end
