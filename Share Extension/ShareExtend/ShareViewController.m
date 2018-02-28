//
//  ShareViewController.m
//  ShareExtend
//
//  Created by Jackylcs on 06/02/2018.
//  Copyright © 2018 jacky. All rights reserved.
//

#import "ShareViewController.h"
#import "ViewController.h"

static NSString *cellId = @"MyCellID";

@interface ShareViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTV;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myTV registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"Storage Bot";
    }
    else {
        cell.textLabel.text = [NSString stringWithFormat:@"User %ld", (long)indexPath.row];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Caption" message:@"Please insert caption or leave it blank." preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Captions or Blank";
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields[0];
        NSLog(@"Ok Send :: %@", textField.text);
        [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    NSString *suiteName = @"group.jacky.share.group";
    NSString *imageKey = @"ImageKey";
    NSString *captionKey = @"CaptionKey";
    
    NSExtensionItem *content = self.extensionContext.inputItems[0];
    NSString *contentType = @"public.image";//kCIAttributeTypeImage; //https://stackoverflow.com/a/47389866
    
    for (NSItemProvider *attachment in content.attachments ) {
        
        if([attachment hasItemConformingToTypeIdentifier:contentType]) {
            NSLog(@"attachment = %@", attachment);
            [attachment loadItemForTypeIdentifier:contentType options:nil completionHandler: ^(id<NSSecureCoding> item, NSError *error) {
                
                if (error) {
                    NSLog(@"Share Error :: %@", error);
                    return;
                }
                NSLog(@"NSSecureCoding :: %@", item);
                NSData *imgData;
                if([(NSObject*)item isKindOfClass:[NSURL class]]) {
                    imgData = [NSData dataWithContentsOfURL:(NSURL*)item];
                }
                
                if([(NSObject*)item isKindOfClass:[UIImage class]]) {
                    imgData = UIImagePNGRepresentation((UIImage*)item);
                }
                
                NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
                [defaults setObject:imgData forKey:imageKey];
//                [defaults setObject:self.contentText forKey:captionKey];
                [defaults synchronize];
            }];
        }
    }
    
}

- (void)aadidSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    SLComposeSheetConfigurationItem *sentToBot = [SLComposeSheetConfigurationItem new];
    sentToBot.title = @"Send to Storage Bot";
    sentToBot.value = @"Apa Value?";
    sentToBot.tapHandler = ^{
        NSLog(@"Will send to BOT");
//        ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
//        pushconfo
    };
    
    SLComposeSheetConfigurationItem *sentToFriend = [SLComposeSheetConfigurationItem new];
    sentToFriend.title = @"Send to Friend";
    sentToFriend.value = @"What's friend?";
    sentToFriend.tapHandler = ^{
        NSLog(@"Will send to friend");
    };
    
    return @[sentToBot, sentToFriend];
}



@end
