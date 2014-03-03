//
//  RemoteCallViewController.m
//  RemoteCall
//
//  Created by Pablo Dimenza on 15/01/14.
//  Copyright (c) 2014 Pablo Dimenza. All rights reserved.
//

#import "RemoteCallViewController.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RemoteCallViewController ()
- (IBAction)callButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (strong, nonatomic) NSDictionary *callResult;
@property (assign, nonatomic) BOOL isDataValid;
@property (weak, nonatomic) IBOutlet MKMapView *mainMap;

@end

@implementation RemoteCallViewController

- (IBAction)callButtonAction:(UIButton *)sender {
    
    if (!self.isDataValid) {
    
    UIFont * font = [UIFont fontWithName:@"Courier New" size: 6.0];
    NSDictionary *result = [self callResult];
    [[self mainLabel] setFont: font];
    [[self mainLabel] setText: [result description]];
    [[self mainLabel] sizeToFit];
    //declare latitude and longitude of map center
    CLLocationCoordinate2D center;
    center.latitude = [[[result valueForKey:@"coord"] valueForKey:@"lat"] floatValue];
    center.longitude = [[[result valueForKey:@"coord"] valueForKey:@"lon"] floatValue];
    //declare span of map (height and width in degrees)
    MKCoordinateSpan span;
    span.latitudeDelta = .02;
    span.longitudeDelta = .01;
    //add center and span to a region,
    //adjust the region to fit in the mapview
    //and assign to mapview region
    MKCoordinateRegion region;
    region.center = center;
    region.span = span;
    self.mainMap.region = [self.mainMap regionThatFits:region];
    }
}

- (NSDictionary *) callResult{
    if (_callResult == nil){
        NSError *error;
        NSString *webserviceURL = @"http://api.openweathermap.org/data/2.5/weather?q=Lisbon,pt";
        id jsonResult = [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:webserviceURL]] options:0 error:&error];
        if (!error) _callResult = (NSDictionary *) jsonResult;
        else _callResult = [NSDictionary alloc];
        self.isDataValid = !error;
    }
    return _callResult;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mainMap.showsUserLocation = YES;
    self.mainMap set
    self.isDataValid = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
