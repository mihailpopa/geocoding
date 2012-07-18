//
//  InterestPoint.m
//  Learn18Geocode
//
//  Created by Mihai Popa on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InterestPoint.h"

@implementation InterestPoint
@synthesize coordinate,title,placemark;
- (id) initWithCoordinate:(CLLocationCoordinate2D)coord
{
    coordinate = coord;
    return self;
}
-(id)init
{
    if (self = [self initWithCoordinate:CLLocationCoordinate2DMake(0.0, 0.0)])
    {
        
    }
        return self;
    
}
@end
