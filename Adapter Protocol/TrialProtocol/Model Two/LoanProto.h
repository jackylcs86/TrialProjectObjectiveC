//
//  LoanProto.h
//  TrialProtocol
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonProto.h"

@protocol LoanProto <CommonProto>
@property (strong) NSString *expiredDate;
- (void)payLoan;
@end

@interface LoanProto : NSObject <LoanProto>

@end
