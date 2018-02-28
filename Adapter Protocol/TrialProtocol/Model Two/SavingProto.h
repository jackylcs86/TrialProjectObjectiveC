//
//  SavingProto.h
//  TrialProtocol
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonProto.h"

@protocol SavingProto <CommonProto>
@property (strong) NSString *benefit;
- (void)insertSaving;
@end

@interface SavingProto : NSObject <SavingProto>

@end
