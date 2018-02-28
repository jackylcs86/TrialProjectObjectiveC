//
//  ViewController.m
//  TrialChatBot
//
//  Created by Jackylcs on 09/01/2018.
//  Copyright © 2018 weeclicks. All rights reserved.
//

#import "ViewController.h"
#import <ApiAI/ApiAI.h>
#import <AVFoundation/AVFoundation.h>
#import <Speech/Speech.h>

@interface ViewController () <SFSpeechRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblBotReply;
@property (weak, nonatomic) IBOutlet UITextField *tfMsgToBot;
@property (weak, nonatomic) IBOutlet UIButton *btnMicroPhone;
- (IBAction)sendMessageToBot:(id)sender;
- (IBAction)speakToText:(id)sender;

@property (nonatomic, strong) SFSpeechRecognizer *speechRec NS_AVAILABLE_IOS(10.0);
@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *recRequest NS_AVAILABLE_IOS(10.0);
@property (nonatomic, strong) SFSpeechRecognitionTask *recTask NS_AVAILABLE_IOS(10.0);
@property (nonatomic, strong) AVAudioEngine *audioEngine;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSpeech];
}

#pragma mark - Speech
- (void)setupSpeech {
    self.btnMicroPhone.enabled = NO;
    self.audioEngine = [AVAudioEngine new];
    
    if (@available(iOS 10.0, *)) {
        
        self.speechRec = [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
        self.speechRec.delegate = self;

        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            BOOL isButtonEnabled = NO;
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                    isButtonEnabled = YES;
                    break;
                    
                case SFSpeechRecognizerAuthorizationStatusDenied:
                    isButtonEnabled = NO;
                    break;
                    
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                    isButtonEnabled = NO;
                    break;
                    
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                    isButtonEnabled = NO;
                    break;
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.btnMicroPhone.enabled = isButtonEnabled;
            }];
        }];
    }
    else {
        // Fallback on earlier versions
        self.btnMicroPhone.hidden = YES;
    }
}

- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available NS_AVAILABLE_IOS(10.0){
    self.btnMicroPhone.enabled = available;
}

- (void)startRecording NS_AVAILABLE_IOS(10.0){
    if (self.recTask != nil) {
        [self.recTask cancel];
        self.recTask = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    @try {
        [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
        [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
        [audioSession setActive:YES error:nil];
    } @catch (NSException *exception) {
        NSLog(@"audioSession properties weren't set because of an error.");
    }
    
    self.recRequest = [SFSpeechAudioBufferRecognitionRequest new];
    
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    self.recRequest.shouldReportPartialResults = YES;
    self.recTask = [self.speechRec recognitionTaskWithRequest:self.recRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        BOOL isFinal = NO;
        if (result != nil) {
            NSLog(@"text::%@", result.bestTranscription.formattedString);
            isFinal = result.isFinal;
        }
        if (error != nil || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            self.recRequest = nil;
            self.recTask = nil;
            self.btnMicroPhone.enabled = YES;
        }
    }];
    
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [self.recRequest appendAudioPCMBuffer:buffer];
    }];
    
    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:nil];
    NSLog(@"Say sth!!");
}

// Speak out the BOT reply
- (void)speechAndText:(NSString *)text {
    
    AVSpeechUtterance *speechUtterance = [AVSpeechUtterance speechUtteranceWithString:text];
    
    AVSpeechSynthesizer *speechSynthesizer = [AVSpeechSynthesizer new];
    [speechSynthesizer speakUtterance:speechUtterance];
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.lblBotReply.text = text;
    } completion:nil];
}

#pragma mark - IBAction
- (IBAction)sendMessageToBot:(id)sender {
    AITextRequest *request = [[ApiAI sharedApiAI] textRequest];
    if (self.tfMsgToBot.text == 0) {
        return;
    }
    
    request.query = self.tfMsgToBot.text;
    [request setMappedCompletionBlockSuccess:^(AIRequest *request, id response) {
        AIResponse *respo = response;
        NSLog(@"messages :: %@", respo.result.fulfillment.messages);
        NSDictionary *dict = respo.result.fulfillment.messages[0];
        [self speechAndText:dict[@"speech"]];
    } failure:^(AIRequest *request, NSError *error) {
        NSLog(@"AITextRequest error :: %@", error);
    }];
    
    [[ApiAI sharedApiAI] enqueue:request];
}

- (IBAction)speakToText:(id)sender {
    if (self.audioEngine.isRunning) {
        [self.audioEngine stop];
        if (@available(iOS 10.0, *)) {
            [self.recRequest endAudio];
        }
        self.btnMicroPhone.enabled = NO;
        [self.btnMicroPhone setTitle:@"Start" forState:UIControlStateNormal];
    }
    else {
        if (@available(iOS 10.0, *)) {
            [self startRecording];
        }
        [self.btnMicroPhone setTitle:@"Stop" forState:UIControlStateNormal];
    }
}


@end
