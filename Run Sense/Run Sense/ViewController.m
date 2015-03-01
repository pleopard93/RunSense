//
//  ViewController.m
//  Run Sense
//
//  Created by Patrick Leopard on 2/28/15.
//  Copyright (c) 2015 Hack DFW. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) BLE *ble;

@end

@implementation ViewController

@synthesize ble;

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    totalStepsArray = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:4], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:3], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], [NSNumber numberWithInt:3], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:4], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:2], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:4], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:2], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:3], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:3], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:2], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:4], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:4], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:2], nil];
    
    [self customizeAppearance];
    
    rollingStepsArray = [[NSMutableArray alloc] init];
    
    heelCount = 0;
    leftBallCount = 0;
    rightBallCount = 0;
    
    [self setUpBLE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self performSelectorInBackground:@selector(startRun) withObject:nil];
}

- (void)customizeAppearance
{
    [self.heelLabel setText:[NSString stringWithFormat:@"%d", heelCount]];
    [self.leftBallLabel setText:[NSString stringWithFormat:@"%d", leftBallCount]];
    [self.rightBallLabel setText:[NSString stringWithFormat:@"%d", rightBallCount]];
}

#pragma mark - Heatmap

- (void)updateLabel:(NSNumber *)stepLocation
{
    switch ([stepLocation integerValue]) {
        case 1:
            heelCount++;
            float stepFloat = (float)heelCount+10;
            [self.heelLabel setText:[NSString stringWithFormat:@"%d", heelCount]];
            //[self.heelLabel setBackgroundColor:[UIColor colorWithRed:stepFloat/255.0f green:100.0/255.0f blue:100.0/255.0f alpha:1.0]];
            self.heelLabel.backgroundColor = [UIColor colorWithRed:stepFloat/255.0f green:100.0/255.0f blue:100.0/255.0f alpha:1.0];
            break;
        case 2:
            leftBallCount++;
            [self.leftBallLabel setText:[NSString stringWithFormat:@"%d", leftBallCount]];
            break;
        case 3:
            rightBallCount++;
            [self.rightBallLabel setText:[NSString stringWithFormat:@"%d", rightBallCount]];
            break;
        default:
            break;
    }
}

#pragma mark - Run Methods

- (void)startRun
{
    for (NSNumber *stepLocation in totalStepsArray) {
        [self takeStep:stepLocation];
        
        // Sleep for a set time
        [NSThread sleepForTimeInterval:.1];
    }
}

- (void)takeStep:(NSNumber *)stepLocation
{
    if ([rollingStepsArray count] < 20) {
        [rollingStepsArray addObject:stepLocation];
    } else {
        [rollingStepsArray removeObjectAtIndex:0];
        [rollingStepsArray addObject:stepLocation];
    }
    
    // Perform UI update on main thread
    [self performSelectorOnMainThread:@selector(updateLabel:) withObject:stepLocation waitUntilDone:YES];
}

#pragma mark - BLE

- (void)setUpBLE
{
    ble = [[BLE alloc] init];
    [ble controlSetup];
    ble.delegate = self;
}

- (IBAction)pushConnectButton:(id)sender
{
    if (ble.activePeripheral) {
        if(ble.activePeripheral.state == CBPeripheralStateConnected) {
            [[ble CM] cancelPeripheralConnection:[ble activePeripheral]];
            [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
            return;
        }
    }
    
    if (ble.peripherals) {
        ble.peripherals = nil;
    }
    
    [self.connectButton setEnabled:false];
    [ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    [self.connectButton setTitle:@"Connecting..." forState:UIControlStateNormal];
}

-(void) connectionTimer:(NSTimer *)timer
{
    [self.connectButton setEnabled:true];
    [self.connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
    
    if (ble.peripherals.count > 0) {
        NSLog(@"Found BLE devices...");
        NSMutableArray *periphs = ble.peripherals;
        
        for (id c in periphs) {
            CBPeripheral *peripheral = (CBPeripheral*)c;
            NSLog(@"Found %@\n", [peripheral name]);
            
            if ([[peripheral name] isEqual:@"hackdfw"]) {
                NSLog(@"Found BLE device. Connecting...");
                [ble connectPeripheral:peripheral];
                
                return;
            }
        }
        
        [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
        
        NSLog(@"Did not find hackdfw...");
    } else {
        [self showAlertView:@"No known devices found" withAlertText:@"Could not find Bluetooth device" withCancelButton:@"Dismiss"];
        
        NSLog(@"No devices found");
        [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    }
}

-(void) bleDidConnect
{
    NSLog(@"Connected to BLE device");
    
    [self showAlertView:@"Connection Success" withAlertText:@"Successfully connected to Bluetooth device" withCancelButton:@"OK"];
}

- (void)bleDidDisconnect
{
    NSLog(@"Disconnected from BLE device");
    
    [self showAlertView:@"Connection Ended" withAlertText:@"Connection to Bluetooth device has ended" withCancelButton:@"Dismiss"];
    
    [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
}

-(void) bleDidReceiveData:(unsigned char *)data length:(int)length
{
    NSLog(@"Length: %d. Data: %d", length, data[0]);
}

#pragma mark - Miscellaneous

- (void)showAlertView:(NSString *)titleLabel withAlertText:(NSString *)alertText withCancelButton:(NSString *)cancelButtonTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleLabel
                                                    message:alertText
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    [alert show];
}

@end
