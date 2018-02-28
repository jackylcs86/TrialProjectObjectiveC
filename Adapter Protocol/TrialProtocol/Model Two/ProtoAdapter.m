//
//  ProtoAdapter.m
//  TrialProtocol
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import "ProtoAdapter.h"

@implementation ProtoAdapter
//@synthesize accName, accNum, amount;

+ (id <SavingProto>)getSavingProto {
    SavingProto *adapter = [SavingProto new];
    return adapter;
}


+ (id <LoanProto>)getLoanProto {
    LoanProto *adapter = [LoanProto new];
    return adapter;
}

@end
