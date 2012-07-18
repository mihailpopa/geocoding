//
//  ViewController.h
//  Learn18Geocode
//
//  Created by Mihai Popa on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "InfoViewController.h"

@interface ViewController : UIViewController<UITextFieldDelegate, MKMapViewDelegate>
{
    BOOL canAddPin;
}

@property (weak, nonatomic) IBOutlet MKMapView *geocodedMap;
@property (weak, nonatomic) IBOutlet UIButton *pinButton;
@property (weak, nonatomic) IBOutlet UITextField *textLocationField;
@property (strong, nonatomic) NSArray *myPlacemarks;
@property (strong, nonatomic) NSMutableArray *geocodedPlaces;


- (IBAction)showPlacemarks:(id)sender;
- (void)addPin:(UITapGestureRecognizer*)recognizer;
- (IBAction)enablePins:(id)sender;
- (IBAction)forwardGeocode:(id)sender;

@end
