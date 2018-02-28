//
//  CommonProto.h
//  TrialProtocol
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LogLazy NSLog(@"[%@] %s", [self class], sel_getName(_cmd));
@protocol CommonProto
@property (strong) NSString *accName;
@property (strong) NSString *accNum;
@property (strong) NSString *amount;
@end

@interface CommonProto : NSObject <CommonProto>

@end
