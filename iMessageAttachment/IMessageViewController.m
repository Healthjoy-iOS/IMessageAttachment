//
//  ViewController.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 3/30/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMessageViewController.h"
#import "IMessageCollectionView.h"
#import "IMessageViewControllerProtocol.h"

@interface IMessageViewController ()<IMessageViewControllerProtocol>

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
    
        [self.attachmentCollectionView setContentOffset:kIMStartPositionOfCollectionView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupProperties {
    self.attachmentCollectionView.VCDelegate = self;
    self.attachmentConent = [NSMutableArray array];
}

#pragma mark - IMessageViewControllerProtocol

- (void)pickedAttachmentImage:(UIImage *)attachmentImage {
    [self.attachmentConent addObject:attachmentImage];
}

@end
