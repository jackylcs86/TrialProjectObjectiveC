//
//  ViewController.m
//  TrialShareExtension
//
//  Created by Jackylcs on 06/02/2018.
//  Copyright © 2018 jacky. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ivSharedImage;
@property (weak, nonatomic) IBOutlet UILabel *lblSharedCaption;

@end
//https://stackoverflow.com/questions/25150579/sharing-bundled-assets-between-app-and-extension
//https://forums.developer.apple.com/thread/14888
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"View Did Load");
    [self loadFromShareExtension];
//    [self extension];
}

- (void)loadFromShareExtension {
    NSString *suiteName = @"group.jacky.share.group";
    NSString *defaultKey = @"ImageKey";
    NSString *captionKey = @"CaptionKey";
    
    NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
    NSData *imageData = [prefs objectForKey:defaultKey];
    self.ivSharedImage.image = [[UIImage alloc] initWithData:imageData];
    self.lblSharedCaption.text = [prefs objectForKey:captionKey];
}

- (void)extension {
    NSString *suiteName = @"group.jacky.share.group";
    NSString *defaultKey = @"ImageKey";
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
                    self.ivSharedImage.image = [UIImage imageWithData:imgData];
                }
                
                if([(NSObject*)item isKindOfClass:[UIImage class]]) {
                    imgData = UIImagePNGRepresentation((UIImage*)item);
                    self.ivSharedImage.image = (UIImage *)item;
                }
                
                NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
//                [defaults setObject:imgData forKey:imageKey];
                //                [defaults setObject:self.contentText forKey:captionKey];
                [defaults synchronize];
            }];
        }
    }
}
@end
