//
//  BaseAccount.m
//  TrialProtocol
//
//  Created by Jackylcs on 25/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import "BaseAccount.h"
#import "AccountInfo.h"

@interface BaseAccount ()
@end

@implementation BaseAccount

- (id)initWithAccountInfo:(AccountInfo *)accInfo {
    self = [super init];
    if (self) {
        _accountName = accInfo.accountName;
        _accountNumber = accInfo.accountNumber;
        _amount = accInfo.amount;
        _interest = accInfo.interest;
    }
    return self;
}

@end
