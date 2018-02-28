//
//  AccountInfo.h
//  TrialProtocol
//
//  Created by Jackylcs on 25/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountInfo : NSObject

@property (strong) NSString *accountName;
@property (strong) NSString *accountNumber;
@property (strong) NSString *amount;
@property (strong) NSString *expiredDate; // FD, FD
@property (strong) NSString *interest;
@property (strong) NSString *creditToAcc; // FD

@end
