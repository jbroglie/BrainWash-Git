//
//  DetailViewController.h
//  BrainWashMe
//
//  Created by Justin on 1/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DetailViewController : UIViewController 
<AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    UILabel *nameLabel;
    UILabel *idLabel;
    NSString *titleString;
    NSInteger patternID;
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    UIButton *playButton;
    UIButton *recordButton;
    UIButton *stopButton;
}

@property(nonatomic, retain) IBOutlet UILabel *nameLabel;
@property(nonatomic, retain) IBOutlet UILabel *idLabel;
@property(nonatomic, retain) NSString *titleString;
@property(nonatomic, assign) NSInteger patternID;
@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;

-(IBAction) recordAudio;
-(IBAction) playAudio;
-(IBAction) stop;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil title:(NSString *)setTitle patternID:(NSInteger)setPattern;


@end
