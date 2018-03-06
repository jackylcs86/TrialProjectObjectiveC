//
//  AppDelegate.m
//  TrialLibPhoneNumber
//
//  Created by weeclicks on 06/12/2017.
//  Copyright © 2017 weeclicks. All rights reserved.
//

#import "AppDelegate.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "WCSimInfo.h"

NSString *const kStr_UserDefault_SimCardInfo = @"User Simcard Info";

@interface AppDelegate ()
@property (nonatomic, strong) CTTelephonyNetworkInfo *telephonyNetworkInfo;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /* Prepare the listener to detect if user change simcard */
    self.telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
    __weak AppDelegate *weakSelf = self;

    // Track CTCarrier changes
    // Both the private API and the subscriberCellularProviderDidUpdateNotifier block are not working on iOS 9.2.1
    // https://stackoverflow.com/a/10904517
    // can't detect number change, only check "Mobile network changed. Switch to new phone number?" -- Whatsapp
    // https://apple.stackexchange.com/questions/121843/whatsapp-on-iphone-how-to-switch-to-a-new-phone-number-without-losing-anything
    self.telephonyNetworkInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier* inCTCarrier) {
        NSLog(@"Carrier update notifier::%@", inCTCarrier);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf simCardInfoValidation:inCTCarrier];
        });
    };
    
    [self simCardInfoValidation:self.telephonyNetworkInfo.subscriberCellularProvider];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - SimCard Method
- (void)simCardInfoValidation:(CTCarrier *)carrier {
    if (!carrier) {
        NSLog(@"No Sim Card Detected");
        return;
    }
    NSData *cached = [[NSUserDefaults standardUserDefaults] objectForKey:kStr_UserDefault_SimCardInfo];
    /* Cached it if first time */
    if (!cached) {
        CTCarrier *carrier = self.telephonyNetworkInfo.subscriberCellularProvider;
        [self cachedSimInfo:carrier];
    }
    /* Show alert if different sim card detecter */
    else {
        WCSimInfo *simcard = [NSKeyedUnarchiver unarchiveObjectWithData:cached];
        if (
            [simcard.networkCode isEqualToString:carrier.mobileNetworkCode] &&
            [simcard.countryCode isEqualToString:carrier.mobileCountryCode] &&
            [simcard.isoCode isEqualToString:carrier.isoCountryCode] &&
            [simcard.name isEqualToString:carrier.carrierName]
            ) {
            return;
        }
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"SimCard Detection" message:@"Mobile network changed. Switch to new phone number?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Lets change the number");
            [self cachedSimInfo:carrier];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Please don't disturb");
        }];
        
        [controller addAction:okAction];
        [controller addAction:cancelAction];
        
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [vc presentViewController:controller animated:YES completion:nil];
    }
    
}

- (void)cachedSimInfo:(CTCarrier *)carrier {
    WCSimInfo *simInfo = [WCSimInfo new];
    simInfo.networkCode = carrier.mobileNetworkCode;
    simInfo.countryCode = carrier.mobileCountryCode;
    simInfo.name = carrier.carrierName;
    simInfo.isoCode = carrier.isoCountryCode;
    simInfo.isSupportVOIP = carrier.allowsVOIP;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:simInfo] forKey:kStr_UserDefault_SimCardInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
