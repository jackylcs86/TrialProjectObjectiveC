//
//  LoanAccount.m
//  TrialProtocol
//
//  Created by Jackylcs on 25/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import "LoanAccount.h"
#import "AccountInfo.h"

@implementation LoanAccount
- (id)initWithAccountInfo:(AccountInfo *)accInfo {
    self = [super initWithAccountInfo:accInfo];
    if (self) {
        _expiredDate = accInfo.expiredDate;
    }
    return self;
}
@end
