//
//  ViewController.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 3/30/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMessageViewController.h"
#import "IMessageCollectionView.h"
#import "IMessageViewControllerDelegate.h"

@interface IMessageViewController ()<IMessageViewControllerDelegate>

@property (nonatomic, weak) IBOutlet IMessageCollectionView *attachmentCollectionView;
@property (nonatomic, strong) NSMutableArray<UIImage*> *attachmentConent;

@end

@implementation IMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupProperties];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupProperties {
    self.attachmentCollectionView.VCDelegate = self;
    self.attachmentConent = [NSMutableArray array];
}

- (IBAction)startOrStopStreamButtonDidSelect:(id)sender {
    
    if(![self.attachmentCollectionView isStreamRunning])
        [self.attachmentCollectionView startRunningStream];
    else
        [self.attachmentCollectionView stopRunningStream];
}

#pragma mark - IMessageViewControllerProtocol

- (void)pickedAttachmentImage:(UIImage *)attachmentImage {
    [self.attachmentConent addObject:attachmentImage];
}

@end
