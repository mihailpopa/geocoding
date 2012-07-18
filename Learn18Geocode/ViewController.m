//
//  ViewController.m
//  Learn18Geocode
//
//  Created by Mihai Popa on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "InterestPoint.h"

@implementation ViewController
@synthesize pinButton;
@synthesize textLocationField;
@synthesize geocodedMap;
@synthesize myPlacemarks;
@synthesize geocodedPlaces;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle


-(void)loadView
{
    [super loadView];
    self.title = @"MyPlacemarks";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPin:)];
    [recognizer setNumberOfTapsRequired:1];
    [geocodedMap addGestureRecognizer:recognizer];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setGeocodedMap:nil];
    [self setTextLocationField:nil];
    [self setPinButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)forwardGeocode:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // Geocode a simple string using a completion handler
    
    NSString *locationString = textLocationField.text;
       [geocoder geocodeAddressString:locationString
                 completionHandler:^(NSArray *placemarks, NSError *error)
    
    {
    if(!error){
                        
                                        // Iterate through all of the placemarks returned
                                        // and output them to the console
    for(CLPlacemark *placemark in placemarks)
    {
        NSLog(@"%@",[placemark description]);
        NSLog(@"%@",[placemark subThoroughfare]);
    }
                                     
                                     
        //Using only one placemark
        //Adding a customized annotation
                                     
                                   
    CLPlacemark *placemark = [placemarks objectAtIndex:0];
    MKCoordinateRegion region;
                                     
    InterestPoint *annotation = [[InterestPoint alloc] initWithCoordinate:placemark.region.center];
    [annotation setTitle:[placemark locality]];
    [geocodedMap addAnnotation:annotation];
    
    NSMutableArray *placemarks = [NSMutableArray arrayWithArray:myPlacemarks];
    [placemarks addObject:annotation];
    self.myPlacemarks = placemarks;
        
    NSMutableDictionary *placemarksDictionary = [[NSMutableDictionary alloc] init];
        
    if ([placemark country]!=nil)
        [placemarksDictionary setObject:[placemark country] forKey:@"Country"];
    if ([placemark locality]!=nil)
        [placemarksDictionary setObject:[placemark locality] forKey:@"Locality"];
    if ([placemark subThoroughfare]!=nil)
        [placemarksDictionary setObject:[placemark subThoroughfare] forKey:@"SubThoroughfare"];

    if (!self.geocodedPlaces)
        self.geocodedPlaces = [[NSMutableArray alloc] init];
    [self.geocodedPlaces addObject:placemarksDictionary];
        NSLog(@"My geocoded places: %@", [self.geocodedPlaces objectAtIndex:0]);
        
        
    region.center.latitude = placemark.region.center.latitude;
    region.center.longitude = placemark.region.center.longitude;
    MKCoordinateSpan span;
        
    double radius = placemark.region.radius / 1000; // convert to km
    NSLog(@"Radius is %f", radius);
    span.latitudeDelta = radius / 112;
    region.span = span;
    [geocodedMap setRegion:region animated:YES];
        
        

    }       else
    {
        NSLog(@"There was a forward geocoding error\n%@",[error localizedDescription]);
    }
                 }];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)showPlacemarks:(id)sender {
    for (InterestPoint *point in myPlacemarks)
    {
        [geocodedMap addAnnotation:point];
    }
}
- (void)addPin:(UITapGestureRecognizer*)recognizer
{
    if (canAddPin)
    {
    CGPoint tappedPoint = [recognizer locationInView:geocodedMap];
    NSLog(@"Tapped At : %@",NSStringFromCGPoint(tappedPoint));
    CLLocationCoordinate2D coord= [geocodedMap convertPoint:tappedPoint toCoordinateFromView:geocodedMap];
    NSLog(@"lat  %f",coord.latitude);
    NSLog(@"long %f",coord.longitude);
    InterestPoint *annotation = [[InterestPoint alloc] initWithCoordinate:coord];
    [geocodedMap addAnnotation:annotation];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
    [annotation setTitle:@"Added annotation"];
    NSLog(@"My annotation is %@", annotation);
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:
         ^(NSArray* placemarks, NSError* error){
             if ([placemarks count] > 0)
             {
                 NSLog(@"Placemarks for this coordinate, %@", placemarks);  
                 MKPlacemark *placemark = [placemarks objectAtIndex:0];
                 NSLog(@"Country for the placemark is %@", [placemark country]);

             }
         }];
    }
}
- (IBAction)enablePins:(id)sender {
    if (canAddPin)
    {
        canAddPin = NO;  
        [self.pinButton setTitle:@"Add places" forState:UIControlStateNormal];
    }
    else 
    {
        canAddPin = YES;
        [self.pinButton setTitle:@"Stop add" forState:UIControlStateNormal];
    }
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    InfoViewController *anotherView = [[InfoViewController alloc] init];
    anotherView.annotationTitle = [view.annotation title];
    [self.navigationController pushViewController:anotherView animated:YES];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[InterestPoint class]]){
        InterestPoint *a = (InterestPoint *) annotation;
        [a setTitle:[annotation title]];
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [geocodedMap dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoLight];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
        annotationView.image = [UIImage imageNamed:@"Pointy.gif"];
        return annotationView;  
    }
    
    return nil;    
}
@end
