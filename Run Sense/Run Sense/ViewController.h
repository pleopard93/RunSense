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
    NSMutableArray *rollingStepsArray;
    int heelCount;
    int leftBallCount;
    int rightBallCount;
}

@property (weak, nonatomic) IBOutlet UILabel *leftBallLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightBallLabel;
@property (weak, nonatomic) IBOutlet UILabel *heelLabel;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

- (IBAction)pushConnectButton:(id)sender;

@end

