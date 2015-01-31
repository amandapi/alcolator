//
//  ViewController.m
//  Alcolator
//
//  Created by Amanda Pi on 2015-01-21.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;
@end

@implementation ViewController

- (void)loadView {
    // Allocate and initialize the all-emcompassing view
    self.view = [[UIView alloc] init];
    
    // Allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // Add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (instancetype) init {
    self = [super init];
    // set title here
    if (self) {
        self.title = NSLocalizedString(@"Wine", @"wine");
        
        // Since we don't have icons, let's move the title to the middle of the tab bar
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    return self;
}

- (void)viewDidLoad {
    
    // Calls the superclass's implementation
    [super viewDidLoad];
   
    // Set our primary view's background color to lightGreyColor
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Tell the text field that 'self', this instance of 'ViewController' should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Assignment 3 of Checkpoint Sizing and Styling to change text field background to non transparent
    [self.beerPercentTextField setBackgroundColor:[UIColor whiteColor]];
    // End Assignment 3
    
    // Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    /* Tell 'self.beerCounterSlider' that when its value changes, to call '[self -sliderValueDidChange:]' -- This is equivalent to connecting the IBAction in previous checkpoint */
    
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:)forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Tell 'self.calculateButton' that when a finger is lifted from the button while still inside its bounds, to call '[self -buttonPressed:]'
    [self.calculateButton addTarget:self action:@selector(buttonPressed:)forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    // Assignment 4 of Checkpoint Sizing and Stylling to turn button title color to red
    [self.calculateButton setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    // end Assignment 4
    
    // Tell the tap gesture recognizer to call '[self -tapGestureDidFire:]' when it detects a tap
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Get rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    
    // Set a background color for the controller
    self.view.backgroundColor = [UIColor colorWithRed:0.741 green:0.925 blue:0.714 alpha:1]; /*#bdec6 which is a beautiful pastel green*/
}




- (void) viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
 
    // To fit app to different devices - replace 320 by CGRectGetWidth(self.view.frame);
    //CGFloat viewWidth = 320;
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    // Also redefine Height for use later to "save the button"
    CGFloat viewHeight = CGRectGetHeight(self.view.frame);
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight); // meaning 20, 20, 280, 44
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame); // CGRectMaxY calculate this: y of frame + height of frame: 20 further down
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);  // meaning 20, 64 + 20, 280, 44
    
    // We repeat 2 more times,recovering the previous element's bottom-most y, add 20 to it, and set frame base on that location
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 4);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    
    // save the calculateButton!

    if (viewWidth > viewHeight) {  /*this is in landscape mode and we need to save the button*/
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel - itemHeight*4, itemWidth, itemHeight);
    } else {
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel, itemWidth, itemHeight);} // this affects the appearance immediately the view will be redrawn at the location we specified
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];
    
    }

- (void)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    // first, calculate how much alcohol is in all those beers ...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; //assume they are 12 oz bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue]/100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine ...
    
    float ouncesInOneWineGlass = 5; // wine glasses are usually 5 oz
    float alcoholPercentageOfWine = 0.13; // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1){
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
  
    // own assignment "a" changed "numberOfBeers" to (int)sender.value
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    
}
    
- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
