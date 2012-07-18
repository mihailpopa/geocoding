//
//  InfoViewController.h
//  Learn18Geocode
//
//  Created by Mihai Popa on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *infoWebView;
@property (copy, nonatomic) NSString *annotationTitle;

@end
