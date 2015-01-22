//
//  ViewController.m
//  Alcolator
//
//  Created by Amanda Pi on 2015-01-21.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;
@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
// assignment part 1
@property (weak, nonatomic) IBOutlet UILabel *beerCountLabel;
// end of assignment part 1

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textFieldDidChange:(UITextField *)sender {
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}

- (IBAction)sliderViewDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    // assignment 1 - show number of beers as slider moves on beerCountLabel
    _beerCountLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
    // end of assignment 1
    
    // assignment 2 - make label updates with slider value: lines 53-93 is identical to lines 100-140 except lines 92 and 139: "numberOfBeers" is replaced by "(int)sender.value".

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
        
        NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), (int)sender.value, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
        self.resultLabel.text = resultText;
        
    }
    // end of assignment 2 


- (IBAction)buttonPressed:(UIButton *)sender {
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
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    
}
    
- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
