# LSActionView
Alternative to UIActionSheet with a block-based API and a customizable look.

## Installation

- Add `LSActionView.h` and `LSActionView.h` to your project. 
- Add `#import "LSActionView.h"` where your want to use.

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

## Examples

### without title
![LSActionView Example1](https://github.com/tinymind/LSActionView/raw/master/example1.png)  

### with title
![LSActionView Example2](https://github.com/tinymind/LSActionView/raw/master/example2.png)  

### landscape
![LSActionView Example3](https://github.com/tinymind/LSActionView/raw/master/example3.png)