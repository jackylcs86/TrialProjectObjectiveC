//
//  SavingProto.m
//  TrialProtocol
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import "SavingProto.h"

@implementation SavingProto
@synthesize accName, accNum, amount, benefit;

#pragma mark - Properties
- (NSString *)accName {
    if (!self->accName) {
        return @"Saving Account Lai de";
    }
    return self->accName;
}

#pragma mark - Method
- (void)insertSaving {
    LogLazy
}

@end
