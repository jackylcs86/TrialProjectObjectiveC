//
//  FixedDepositAccount.h
//  TrialProtocol
//
//  Created by Jackylcs on 25/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAccount.h"

@interface FixedDepositAccount : BaseAccount
@property (strong) NSString *expiredDate;
@property (strong) NSString *creditToAcc; // FD
@end
