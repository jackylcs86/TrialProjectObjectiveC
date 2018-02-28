//
//  ViewController.m
//  TrialPhotoBuf
//
//  Created by weeclicks on 05/12/2017.
//  Copyright © 2017 weeclicks. All rights reserved.
//

#import "ViewController.h"
#import "Contact.pbobjc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Person *contact = [[Person alloc] init];
    contact.name = @"Jacky";
    contact.age = 31;
    contact.gender = @"Male";
    
    NSData *personData = [contact data];
    
    NSError *error = nil;
    Person *personGet = [Person parseFromData:personData error:&error];
    if (error) {
        NSLog(@"%@", error.description);
    }
    else {
        NSLog(@"%@", personGet);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
