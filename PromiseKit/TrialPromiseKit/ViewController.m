//
//  ViewController.m
//  TrialPromiseKit
//
//  Created by weeclicks on 06/12/2017.
//  Copyright © 2017 weeclicks. All rights reserved.
//

#import "ViewController.h"
#import <PromiseKit/PromiseKit.h>
#import <PromiseKit/NSURLSession+AnyPromise.h>
#import <PromiseKit/NSNotificationCenter+AnyPromise.h>
#import <PromiseKit/UIView+AnyPromise.h>

@interface ViewController () <UIAlertViewDelegate>
- (IBAction)displayAction:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self exampleOne];
    [self exampleTwo];
    [self exampleThree];
}

- (AnyPromise *)downloadSongMetadata:(NSString *)artist title:(NSString *)title {
    
    return [AnyPromise promiseWithValue:nil];
}

#pragma mark - Example Three : Notification Center Promise
- (void)exampleThree {
    // *** Only execute one time !!
    [NSNotificationCenter once:UIKeyboardWillShowNotification].then(^(id note, id userInfo){
        NSLog(@"Keyboard Show :: %@ -- %@", note, userInfo);
        UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        return [UIView promiseWithDuration:duration delay:0.0 options:(curve << 16) animations:^{
            
        }];
    });
    
}

#pragma mark - Example Two : Dispatch_Promise

- (void)exampleTwo {
    dispatch_promise(^{
        NSLog(@"Start Download");
        return [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://a1.ifengimg.com/autoimg/serial/500/10637_3.png"]];
    }).then(^(NSData * imageData){
        NSLog(@"Get Image Data");
        self.ivImage.image = [UIImage imageWithData:imageData];
    }).then(^{
        // add code to happen next here
        NSLog(@"Picture loaded");
    });
}

#pragma mark - Example One
- (void)exampleOne {
    __block NSString *title = @"";
    __block NSString *msg = @"";
    
    [self myPromise].then(^(NSString *bar) {
        NSLog(@"Return of :: %@", bar);
        title = bar;
        return [self anotherPromise];
        
    }).then(^(NSArray *fetechedData){
        NSLog(@"My array :: %@", fetechedData);
        msg = fetechedData[0];
        return [self alertDecision:title msg:msg];
        
    }).then(^(NSString * buttonClicked) {
        NSLog(@"User click ok");
        return [self sureError:([buttonClicked isEqualToString:@"OK"])];
        
    }).then(^{
        NSLog(@"Sure error wouldn't return here");
        
    }).catch(^(NSError *error) {
        // Catch Error
        NSLog(@"Catch Error %@", error);
    });
}

// Normal Promise , return NSString
- (AnyPromise *)myPromise {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
        sleep(3);
        NSString *bar = @"Gao dim";
        resolve(bar);
    }];
}

// Normal Prmoise , return NSArray
- (AnyPromise *)anotherPromise {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
        sleep(3);
        NSArray *array = @[@"Apple", @"Orange", @"Pineapple"];
        resolve(array);
    }];
}

// Alert Promise, return after user click on Alert
- (AnyPromise *)alertDecision:(NSString *)title msg:(NSString *)msg {
    NSString *pass = @"OK";
    NSString *failed = @"Failed it";
    
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:pass style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            resolve(pass);
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:failed style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            resolve(failed);
        }];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (AnyPromise *)sureError:(BOOL)isSuccess {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
        sleep(3);
        if (isSuccess) {
            resolve(@"");
        }
        else {
            NSError *theError = [NSError errorWithDomain:@"www.google.com" code:99 userInfo:@{}];
            resolve(theError);
        }
    }];
}

#pragma mark - UIAlertView

- (IBAction)displayAction:(id)sender {
    [self.view endEditing:YES];
}




@end


