//
//  FixedDepositAccount.m
//  TrialProtocol
//
//  Created by Jackylcs on 25/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import "FixedDepositAccount.h"
#import "AccountInfo.h"

@implementation FixedDepositAccount

- (id)initWithAccountInfo:(AccountInfo *)accInfo {
    self = [super initWithAccountInfo:accInfo];
    if (self) {
        _expiredDate = accInfo.expiredDate;
        _creditToAcc = accInfo.creditToAcc;
    }
    return self;
}

@end
