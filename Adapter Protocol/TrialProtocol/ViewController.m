//
//  ViewController.m
//  TrialProtocol
//
//  Created by Jackylcs on 24/02/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import "ViewController.h"
#import "AccountInfo.h"
#import "SavingAccount.h"
#import "ProtoAdapter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadSavingAccount];
    [self loadProto];
}

#pragma mark - Model Two
- (void)loadProto {
    id<SavingProto> savingAcc = [ProtoAdapter getSavingProto];
    NSLog(@"Saving Pre-accName::%@", savingAcc.accName);
    savingAcc.accName = @"Saving Account MO2";
    savingAcc.accNum = @"1021312301231";
    savingAcc.amount = @"1000000.00";
    savingAcc.benefit = @"Liew";
    NSLog(@"Saving Post-accName::%@", savingAcc.accName);
    [savingAcc insertSaving];
    
    NSLog(@"==================================================================");
    
    id<LoanProto> loanAcc = [ProtoAdapter getLoanProto];
    NSLog(@"Loan Pre-accName::%@", loanAcc.accName);
    loanAcc.accName = @"Loan Account MO2";
    loanAcc.accNum = @"1021312301231";
    loanAcc.amount = @"1000000.00";
    loanAcc.expiredDate = @"Tomorrow";
    NSLog(@"Loan Post-accName::%@", loanAcc.accName);
    [loanAcc payLoan];
}

#pragma mark - Model One
- (void)loadSavingAccount {
    SavingAccount *savAcc = [[SavingAccount alloc] initWithAccountInfo:[self hardcodeSavingAcc]];
    NSLog(@"AccName :: %@", savAcc.accountName);
    NSLog(@"AccNumber :: %@", savAcc.accountNumber);
    NSLog(@"Amount :: %@", savAcc.amount);
    NSLog(@"interest :: %@", savAcc.interest);
    
}

- (AccountInfo *)hardcodeSavingAcc {
    AccountInfo *info = [AccountInfo new];
    info.accountName = @"Saving Account MO1";
    info.accountNumber = @"1122334455667788";
    info.amount = @"2000000.00";
    info.interest = @"4.0";
    return info;
    
}
@end
