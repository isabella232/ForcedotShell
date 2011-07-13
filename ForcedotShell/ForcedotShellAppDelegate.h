//
//  ForcedotShellAppDelegate.h
//  ForcedotShell
//
//  Created by Quinton Wall on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForcedotShellViewController;

@interface ForcedotShellAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ForcedotShellViewController *viewController;

@end
