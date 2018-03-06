//
//  SimInfo.h
//  TrialLibPhoneNumber
//
//  Created by weeclicks on 07/12/2017.
//  Copyright © 2017 weeclicks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCSimInfo : NSObject <NSCoding>
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *isoCode;
@property (nonatomic, strong) NSString *networkCode;
@property (nonatomic) BOOL isSupportVOIP;
@end
