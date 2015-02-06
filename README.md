# LSActionView
Alternative to UIActionSheet with a block-based API and a customizable look.

## Installation

- Add `LSActionView.h` and `LSActionView.h` to your project. 
- Or use CocoaPods: `pod 'LSActionView'`.

## Requirements

Requires iOS 4.3 and above.

## Usage

``` cpp

  #import "LSActionView.h"

  - (void)onShareTapped:(id)sender {
  
    //show without button title
    NSArray *images = @[@"icon_dropbox", @"icon_rss", @"icon_facebook", @"icon_twitter"];
    [[LSActionView sharedActionView] showWithImages:images actionBlock:^(NSInteger index) {
		NSLog(@"Action trigger at %ld:", (long)index);
	}]; 
                                            
    //show with button title
    NSArray *titles = @[@"Dropbox", @"Rss", @"Facebook", @"Twitter"];
    [[LSActionView sharedActionView] showWithImages:images titles:titles actionBlock:^(NSInteger index) {
		NSLog(@"Action trigger at %ld:", (long)index);
	}];                                             
  }
  
```

## Customizable

``` cpp

  @property (strong, nonatomic) UIColor *blankAreaColor;
  @property (strong, nonatomic) UIColor *containerColor;
  @property (strong, nonatomic) UIColor *buttonTitleColor;
  @property (assign, nonatomic) CGFloat buttonFontSize;
  @property (assign, nonatomic) CGFloat containerMargin;
  @property (assign, nonatomic) CGFloat buttonIconWidth;
  @property (assign, nonatomic) CGFloat buttonTitleHeight;

```

## Examples

### Without title
![LSActionView Example1](https://github.com/tinymind/LSActionView/raw/master/example1.png)  

### With title
![LSActionView Example2](https://github.com/tinymind/LSActionView/raw/master/example2.png)  

### Landscape
![LSActionView Example3](https://github.com/tinymind/LSActionView/raw/master/example3.png)