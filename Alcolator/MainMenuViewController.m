//
//  MainMenuViewController.m
//  Alcolator
//
//  Created by Amanda Pi on 2015-01-25.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"
#import "WhiskeyViewController.h"

@interface MainMenuViewController ()

@property (nonatomic, strong) UIButton *wineButton;
@property (nonatomic, strong) UIButton *whiskeyButton;

@end

@implementation MainMenuViewController

// Create 2 buttons

- (void) loadView {
    self.wineButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.whiskeyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Wine")forState:UIControlStateNormal];
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Whiskey")forState:UIControlStateNormal];
    
    [self.wineButton addTarget:self action:@selector(winePressed:)forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:)forControlEvents:UIControlEventTouchUpInside];
    
    self.view = [[UIView alloc] init];
                 
    [self.view addSubview:self.wineButton];
    [self.view addSubview:self.whiskeyButton];
}
                 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.91f alpha:1];
    
    UIFont *bigFont = [UIFont boldSystemFontOfSize:20];
    
    [self.wineButton.titleLabel setFont:bigFont];
    [self.whiskeyButton.titleLabel setFont:bigFont];
    
    self.title = NSLocalizedString(@"Select Alcolator", @"Select Alcolator");
}


- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect wineButtonFrame, whiskeyButtonFrame;
    CGRectDivide(self.view.bounds, &wineButtonFrame, &whiskeyButtonFrame, CGRectGetWidth(self.view.bounds) / 2, CGRectMinXEdge);
    
    self.wineButton.frame = wineButtonFrame;
    self.whiskeyButton.frame = whiskeyButtonFrame;
}

// Add a target to each button

-(void) winePressed:(UIButton *) sender {
    // First we create (alloc) and run (init) a new viewController called wineVC:
    ViewController *wineVC = [[ViewController alloc] init];
    // Then we look for a navigation controller tell it to push wineVC onto the Navigation Stack:
    [self.navigationController pushViewController:wineVC animated:YES];
    // navigationController is a property of UIViewController that returns the nearest Navigation Controller.
}

-(void) whiskeyPressed:(UIButton *) sender {
    WhiskeyViewController *whiskeyVC = [[WhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
