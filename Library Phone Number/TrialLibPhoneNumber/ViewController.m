//
//  ViewController.m
//  TrialLibPhoneNumber
//
//  Created by weeclicks on 06/12/2017.
//  Copyright © 2017 weeclicks. All rights reserved.
//

#import "ViewController.h"
#import "NBPhoneNumberUtil.h"
#import "AppDelegate.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *number1 = @"0125210833";
    NSString *number2 = @"+60125210833";
    NSLog(@"Validate %@ --> %@", number1, [self validatePhoneNumber:number1]);
    NSLog(@"Validate %@ --> %@", number2, [self validatePhoneNumber:number2]);
//    [self getSimCardDetails];
    
}

#pragma mark - Private Implementation

// Manual way
- (void)getSimCardDetails {
    
    CTTelephonyNetworkInfo* info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier* carrier = info.subscriberCellularProvider;
    NSString *mobileCountryCode = carrier.mobileCountryCode;
    NSString *carrierName = carrier.carrierName;
    NSString *isoCountryCode = carrier.isoCountryCode;
    NSString *mobileNetworkCode = carrier.mobileNetworkCode;
    
    NSLog(@"Mobile Country Code :: %@", mobileCountryCode);
    NSLog(@"Carrier Name :: %@", carrierName);
    NSLog(@"iso Country Code :: %@", isoCountryCode);
    NSLog(@"Mobile Network Code :: %@", mobileNetworkCode);
    

}

- (NSString *)validatePhoneNumber:(NSString *)phoneNumber {
    NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
    NSError *anError = nil;
    
    NSString *currentCountryCode = phoneUtil.countryCodeByCarrier;
    if (currentCountryCode.length == 0 || [currentCountryCode isEqualToString:@"ZZ"]) {
#warning shouldn't have empty country code, unless in simulator
        currentCountryCode = @"my";
    }
    
    NBPhoneNumber *myNumber = [phoneUtil parse:phoneNumber defaultRegion:currentCountryCode error:&anError];
    
    if (anError != nil) {
        NSLog(@"Error : %@", [anError localizedDescription]);
        return @"";
    }
    
    if (![phoneUtil isValidNumber:myNumber]) {
        NSLog(@"Error : Invalid Phone Number");
        return @"";
    }
    
    NSString *num = [phoneUtil format:myNumber numberFormat:NBEPhoneNumberFormatE164 error:&anError];
    
    if (anError != nil) {
        NSLog(@"Error : %@", [anError localizedDescription]);
    }
    
    return num;
    
}

- (NSString *)trial:(NSString *)phoneNumber {
    NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
    NSError *anError = nil;
    
    NSString *currentCountryCode = phoneUtil.countryCodeByCarrier;
    if (currentCountryCode.length == 0 || [currentCountryCode isEqualToString:@"ZZ"]) {
        currentCountryCode = @"my";
    }
    
    NBPhoneNumber *myNumber = [phoneUtil parse:phoneNumber defaultRegion:currentCountryCode error:&anError];
    NSString *nationalNumber = nil;
    NSNumber *countryCode = [phoneUtil extractCountryCode:@"60125210833" nationalNumber:&nationalNumber];
    NSLog (@"extractCountryCode [%@] [%@]", countryCode, nationalNumber);
    
    if (anError == nil) {
        NSLog(@"isValidPhoneNumber ? [%@]", [phoneUtil isValidNumber:myNumber] ? @"YES":@"NO");
        
        // E164          : +436766077303
        NSLog(@"E164          : %@", [phoneUtil format:myNumber
                                          numberFormat:NBEPhoneNumberFormatE164
                                                 error:&anError]);
        // INTERNATIONAL : +43 676 6077303
        NSLog(@"INTERNATIONAL : %@", [phoneUtil format:myNumber
                                          numberFormat:NBEPhoneNumberFormatINTERNATIONAL
                                                 error:&anError]);
        // NATIONAL      : 0676 6077303
        NSLog(@"NATIONAL      : %@", [phoneUtil format:myNumber
                                          numberFormat:NBEPhoneNumberFormatNATIONAL
                                                 error:&anError]);
        // RFC3966       : tel:+43-676-6077303
        NSLog(@"RFC3966       : %@", [phoneUtil format:myNumber
                                          numberFormat:NBEPhoneNumberFormatRFC3966
                                                 error:&anError]);
        
        if ([phoneUtil isValidNumber:myNumber]) {
            return [phoneUtil format:myNumber numberFormat:NBEPhoneNumberFormatE164 error:&anError];
        }
    }
    else {
        NSLog(@"Error : %@", [anError localizedDescription]);
        return @"";
    }
    
    return @"";

}


@end
