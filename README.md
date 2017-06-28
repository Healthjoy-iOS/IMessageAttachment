
## IMessageAttachment inspired and copied from iMessage attachment control. 

A simple iOS photo attachment control with feed of photos from library and camera streaming for capture photo.

Attachment control from iMessage:<br />
[![Alt][screenshot1_thumb]][screenshot1]    [![Alt][screenshot2_thumb]][screenshot2]
<br />IMessageAttachment example:<br />    
[![Alt][screenshot3_thumb]][screenshot3]    [![Alt][screenshot4_thumb]][screenshot4]   
<br />IMessageAttachment implementetion in a project:<br /> 
[![Alt][screenshot5_thumb]][screenshot5]    [![Alt][screenshot6_thumb]][screenshot6]

[screenshot1_thumb]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/iMessaget.PNG
[screenshot1]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/iMessage.PNG
[screenshot2_thumb]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/iMessage1t.PNG
[screenshot2]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/iMessage1.PNG
[screenshot3_thumb]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/examplet.PNG
[screenshot3]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/example.PNG
[screenshot4_thumb]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/example1t.PNG
[screenshot4]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/example1.PNG
[screenshot5_thumb]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/impt.PNG
[screenshot5]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/imp.PNG
[screenshot6_thumb]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/imp1t.PNG
[screenshot6]: https://raw.githubusercontent.com/nekromarko/IMessageAttachment/master/Screenshots/imp1.PNG

Works on iOS 8+.

## Usage

IMessageAttachment is just a `UICollectionView` with controls, designed for use with keyboard like in iMessage application. Setup IMessageCollectionView in your viewController, set the delegate (which must conform to IMessageViewControllerDelegate) and implement the 1 required delegate methods to provide `UIImage` from controls.

See the code snippet below for an example of how to implement the IMessageAttachment control. There is also a simple demo app within the project.

```obj-c
// define IMessageCollectionView
@property (nonatomic, weak) IBOutlet IMessageCollectionView *attachmentCollectionView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *attachmentCollectionViewHeightConstraint;

// set delegate in viewDidLoad()
self.attachmentCollectionView.VCDelegate = self;

// define IMessageViewControllerProtocol
- (void)pickedAttachmentImage:(UIImage *)attachmentImage {
    [self.attachmentContent addObject:attachmentImage];
}
```

You can update attachmentCollectionView's height automatically by take keyboard's height. And it's required thing if you wanna work like iMessage attachment control with keyboard. 

```obj-c
// setup notification
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(updateAttachmentHeight:)
                                             name:UIKeyboardDidShowNotification
                                           object:nil];

// update attachmentCollectionView's height
- (void)updateAttachmentHeight:(NSNotification*)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGFloat height = [keyboardFrameBegin CGRectValue].size.height;

    self.attachmentCollectionViewHeightConstraint.constant = height;
    [self.attachmentCollectionView updateCollectionViewHeight:height];
}
```

That's all. 

## Installation 

IMessageAttachment is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "IMessageAttachment"
```

Or you can copy IMessageAttachment folder to your project.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Then import the IMessageCollectionView into your source files:

```obj-c
#import "IMessageCollectionView.h"
```

## Author

Mark Prutskiy, portals.gaming@gmail.com


## License

IMessageAttachment is available under the MIT license. See the LICENSE file for more info.
