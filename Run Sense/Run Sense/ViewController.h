//
//  ViewController.h
//  Run Sense
//
//  Created by Patrick Leopard on 2/28/15.
//  Copyright (c) 2015 Hack DFW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Definitions.h"
#import "BLE.h"

@interface ViewController : UIViewController <BLEDelegate>
{
    NSArray *totalStepsArray;
    NSArray *heatColorsArray;
    NSMutableArray *rollingStepsArray;
    NSMutableArray *stepDataArray;
    int goodStepCount;
    int overpronationStepCount;
    int underpronationStepCount;
    int pranceStepCount;
    int heelStrikeCount;
}

@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIImageView *footImage;
@property (weak, nonatomic) IBOutlet UIImageView *footLeftImage;
@property (weak, nonatomic) IBOutlet UIImageView *footRightImage;
@property (weak, nonatomic) IBOutlet UIImageView *footHeelImage;

- (IBAction)pushConnectButton:(id)sender;

@end

