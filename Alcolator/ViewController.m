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


- (void)viewDidLoad {
    
    // Calls the superclass's implementation
    [super viewDidLoad];
   
    // Set our primary view's background color to lightGreyColor
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Tell the text field that 'self', this instance of 'ViewController' should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Assignment 3 of Checkpoint Sizing and Styling to change text field background to non transparent
    [_beerPercentTextField setBackgroundColor:[UIColor whiteColor]];
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
    
    // Set a title for the controller
    self.title = NSLocalizedString(@"Wine", @"wine");
}

- (void) viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    // Assignment 2 of Checkpoint Sizing and Styling to fit app to different devices - replace 320 by CGRectGetWidth(self.view.frame);
    //CGFloat viewWidth = 320;
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    // end Assignment 2
    
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    // own assignment "0" The beerPercentTextField was too high and hidden by he navigation bar so I changed y-padding to padding * 4
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding * 4, itemWidth, itemHeight); // meaning 20, 20*4, 280, 44
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame); // CGRectMaxY calculate this: y of frame + height of frame: 20 further down
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);  // meaning 20, 64 + 20, 280, 44
    
    // We repeat 2 more times,recovering the previous element's bottom-most y, add 20 to it, and set frame base on that location
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 4);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding,bottomOfLabel + padding, itemWidth, itemHeight); // this affects the appearance immediately  the view will be redrawn at the location we specified
    
    // Assignment 1 of Checkpoint Sizing and Styling to make the app handle all rotations by adding this line:
    [self.view convertRect:self.view.frame fromView:self.view.superview];
    // End of Assignment 1
    
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
    
    // Assignment 2 of Checkpoint Tapped Navigation - to show numbers of glasses of wine or shots of whiskeys in title view
    // Maths (copied all the math lines from buttonPressed method - some lines are probably not needed but I am trying to be lazy here):
    
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
    
    // Generate text on title view
    
    NSString *titleViewText = [NSString stringWithFormat:NSLocalizedString(@"Wine %.1f %@.", nil), numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    
    [self.navigationItem setTitle:titleViewText];

    // End assigment 2
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
