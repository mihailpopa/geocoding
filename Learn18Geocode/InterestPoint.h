//
//  InterestPoint.h
//  Learn18Geocode
//
//  Created by Mihai Popa on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface InterestPoint : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}
@property (copy, nonatomic) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) CLPlacemark *placemark;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord;
@end
