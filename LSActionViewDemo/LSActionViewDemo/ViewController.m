//
//  ViewController.m
//  LSActionViewDemo
//
//  Created by lslin on 15/2/5.
//  Copyright (c) 2015年 LessFun.com. All rights reserved.
//

#import "ViewController.h"
#import "LSActionView.h"

@interface ViewController ()
{
    NSMutableArray *_titles;
    NSMutableArray *_images;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _titles = [NSMutableArray array];
    _images = [NSMutableArray array];
    
    [_titles addObjectsFromArray:@[@"Dropbox", @"Rss", @"Facebook", @"Twitter", @"Dribbble", @"Vimeo", @"LastFM", @"Youtube"]];
    [_images addObjectsFromArray:@[@"icon_dropbox", @"icon_rss", @"icon_facebook", @"icon_twitter", @"icon_dribbble", @"icon_vimeo", @"icon_lastfm", @"icon_youtube"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShareButtonClicked:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tag)];
    NSMutableArray *titles = [NSMutableArray arrayWithArray:[_titles objectsAtIndexes:set]];
    NSMutableArray *images = [NSMutableArray arrayWithArray:[_images objectsAtIndexes:set]];
    
    if (tag == 6) {
        [[LSActionView sharedActionView] showWithImages:images
                                            actionBlock:^(NSInteger index) {
                                                NSLog(@"Action trigger at %ld:", (long)index);
                                            }];
    } else {
        
        [[LSActionView sharedActionView] showWithImages:images
                                                 titles:titles
                                            actionBlock:^(NSInteger index) {
                                                NSLog(@"Action trigger at %ld:", (long)index);
        }];
    }
}

@end
