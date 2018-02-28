//
//  BaseAccount.h
//  TrialProtocol
//
//  Created by Jackylcs on 25/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountInfo;

@interface BaseAccount : NSObject 

- (id)initWithAccountInfo:(AccountInfo *)accInfo;

@property (strong) NSString *accountName;
@property (strong) NSString *accountNumber;
@property (strong) NSString *amount;
@property (strong) NSString *interest;

@end
