//
//  ProtoAdapter.h
//  TrialProtocol
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SavingProto.h"
#import "LoanProto.h"

@interface ProtoAdapter : NSObject
//<SavingProto, LoanProto>

+ (id <SavingProto>)getSavingProto;
+ (id <LoanProto>)getLoanProto;

@end
