//
//  ViewController.m
//  Run Sense
//
//  Created by Patrick Leopard on 2/28/15.
//  Copyright (c) 2015 Hack DFW. All rights reserved.
//

#import "ViewController.h"

#define kColorZone1 [UIColor colorWithRed:255.0/255.0f green:215.0/255.0f blue:0.0/255.0f alpha:1.0]
#define kColorZone2 [UIColor colorWithRed:255.0/255.0f green:69.0/255.0f blue:0.0/255.0f alpha:1.0]
#define kColorZone3 [UIColor colorWithRed:255.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0]

@interface ViewController ()

@property (strong, nonatomic) BLE *ble;

@end

@implementation ViewController

@synthesize ble;

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    heatColorsArray = [[NSArray alloc] initWithObjects:kColorZone1, kColorZone2, kColorZone3, nil];
    rollingStepsArray = [[NSMutableArray alloc] init];
    stepDataArray = [[NSMutableArray alloc] init];
    
    goodStepCount = 0;
    pranceStepCount = 0;
    heelStrikeCount = 0;
    overpronationStepCount = 0;
    underpronationStepCount = 0;
    
    [self setUpBLE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)customizeAppearance
{
    
}

- (void)updateHeatMap:(int)heelZone forLeft:(int)leftZone forRight:(int)rightZone
{
    // Left image
    UIImage *loadImage = [UIImage imageNamed:@"foot_left.png"];
    
    CGRect rect = CGRectMake(0, 0, loadImage.size.width, loadImage.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, loadImage.CGImage);
    CGContextSetFillColorWithColor(context, [[heatColorsArray objectAtIndex:leftZone] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *heatLeftImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    // Right image
    loadImage = [UIImage imageNamed:@"foot_right.png"];
    
    rect = CGRectMake(0, 0, loadImage.size.width, loadImage.size.height);
    UIGraphicsBeginImageContext(rect.size);
    context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, loadImage.CGImage);
    CGContextSetFillColorWithColor(context, [[heatColorsArray objectAtIndex:rightZone] CGColor]);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *heatRightImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    // Heel image
    loadImage = [UIImage imageNamed:@"foot_heel.png"];
    
    rect = CGRectMake(0, 0, loadImage.size.width, loadImage.size.height);
    UIGraphicsBeginImageContext(rect.size);
    context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, loadImage.CGImage);
    CGContextSetFillColorWithColor(context, [[heatColorsArray objectAtIndex:heelZone] CGColor]);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *heatHeelImage = [UIImage imageWithCGImage:img.CGImage
                                                  scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    // Set new heated images
    self.footLeftImage.image = heatLeftImage;
    self.footRightImage.image = heatRightImage;
    self.footHeelImage.image = heatHeelImage;
}

#pragma mark - Step

- (void)analyzeStep:(NSMutableDictionary *)stepDictionary
{
    // 1 Left
    // 2 Right
    // 3 Heel
    
    // Check for prancer and heel strike steps
    if ([stepDictionary objectForKey:@"sd1"] != [NSNumber numberWithChar:3] && [stepDictionary objectForKey:@"sd2"] != [NSNumber numberWithChar:3] && [stepDictionary objectForKey:@"su1"] != [NSNumber numberWithChar:3] && [stepDictionary objectForKey:@"su2"] != [NSNumber numberWithChar:3]) {
        pranceStepCount++;
    } else if ([stepDictionary objectForKey:@"sd1"] == [NSNumber numberWithChar:3] && [stepDictionary objectForKey:@"d1"] > [NSNumber numberWithChar:20]) {
        // Heel striker
        heelStrikeCount++;
        [self registerStep:[NSNumber numberWithInt:0]];
    }
    
    // Check for pronation
    if ([stepDictionary objectForKey:@"sd1"] == [NSNumber numberWithChar:3] && [stepDictionary objectForKey:@"d2"] < [NSNumber numberWithChar:20]) {
        // Good step
        goodStepCount++;
    } else if ([stepDictionary objectForKey:@"sd2"] == [NSNumber numberWithChar:2] && [stepDictionary objectForKey:@"su1"] == [NSNumber numberWithChar:2] && [stepDictionary objectForKey:@"su2"] == [NSNumber numberWithChar:1]) {
        // Overpronator
        overpronationStepCount++;
        [self registerStep:[NSNumber numberWithInt:1]];
    } else if ([stepDictionary objectForKey:@"sd2"] == [NSNumber numberWithChar:2] && [stepDictionary objectForKey:@"su1"] == [NSNumber numberWithChar:1] && [stepDictionary objectForKey:@"su2"] == [NSNumber numberWithChar:2]) {
        // Underpronator
        underpronationStepCount++;
        [self registerStep:[NSNumber numberWithInt:2]];
    }
}

- (void)registerStep:(NSNumber *)stepLocationID
{
    // Keep track of last ten steps for heat map
    if ([rollingStepsArray count] < 10) {
        [rollingStepsArray addObject:stepLocationID];
    } else {
        [rollingStepsArray removeObjectAtIndex:0];
        [rollingStepsArray addObject:stepLocationID];
    }
    
    [self prepareHeatzoneForUpdate];
}

- (void)prepareHeatzoneForUpdate
{
    int rollingHeelStrikeCount = 0;
    int rollingOverpronateCount = 0;
    int rollingUnderpronateCount = 0;
    int heelZone = 0;
    int overpronateZone = 0;
    int underpronateZone = 0;
    
    // Count types of steps in rolling steps array
    for (NSNumber *step in rollingStepsArray) {
        switch ([step integerValue]) {
            case 0:
                rollingHeelStrikeCount++;
                break;
            case 1:
                rollingOverpronateCount++;
                break;
            case 2:
                rollingUnderpronateCount++;
                break;
            default:
                break;
        }
    }
    
    // Count steps for heat zones
    if (rollingHeelStrikeCount < 3) {
        heelZone = 0;
    } else if (rollingHeelStrikeCount >= 3 && rollingHeelStrikeCount < 5) {
        heelZone = 1;
    } else {
        heelZone = 2;
    }
    
    if (rollingOverpronateCount < 3) {
        overpronateZone = 0;
    } else if (rollingOverpronateCount >= 3 && rollingOverpronateCount < 5) {
        overpronateZone = 1;
    } else {
        overpronateZone = 2;
    }
    
    if (rollingUnderpronateCount < 3) {
        underpronateZone = 0;
    } else if (rollingUnderpronateCount >= 3 && rollingUnderpronateCount < 5) {
        underpronateZone = 1;
    } else {
        underpronateZone = 2;
    }
    
    [self updateHeatMap:heelZone forLeft:overpronateZone forRight:underpronateZone];
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
        
        NSLog(@"Did not find device...");
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

- (void)bleDidReceiveData:(unsigned char *)data length:(int)length
{
    // First step down location, second step down location, delay between first two, first step up, second step up, delay between previous two
    NSMutableDictionary *stepDictionary = [[NSMutableDictionary alloc] init];
    
    for (int i=0; i<length; i++) {
        switch (i) {
            case 0:
                [stepDictionary setObject:[NSNumber numberWithChar:data[i]] forKey:@"sd1"];
                break;
            case 1:
                [stepDictionary setObject:[NSNumber numberWithChar:data[i]] forKey:@"sd2"];
                break;
            case 2:
                [stepDictionary setObject:[NSNumber numberWithChar:data[i]] forKey:@"d1"];
                break;
            case 3:
                [stepDictionary setObject:[NSNumber numberWithChar:data[i]] forKey:@"su1"];
                break;
            case 4:
                [stepDictionary setObject:[NSNumber numberWithChar:data[i]] forKey:@"su2"];
                break;
            case 5:
                [stepDictionary setObject:[NSNumber numberWithChar:data[i]] forKey:@"d2"];
                break;
            default:
                break;
        }
    }
    
    [self analyzeStep:stepDictionary];
    
    [stepDataArray addObject:stepDictionary];
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
