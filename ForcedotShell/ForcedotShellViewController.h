//
//  ForcedotShellViewController.h
//  ForcedotShell
//
//  Created by Quinton Wall on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForcedotShellViewController : UIViewController {
    
    IBOutlet UIWebView *webView;
    BOOL autoLoginEnabled;
    BOOL fastSwitchingEnabled;
    NSString *loginURL;
    NSString *returnURL;
    NSString *username;
    NSString *password;
}

@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, readwrite) BOOL autoLoginEnabled;
@property(nonatomic, readwrite) BOOL fastSwitchingEnabled;
@property(nonatomic, readwrite, assign) NSString *loginURL;
@property(nonatomic, readwrite, assign) NSString *returnURL;
@property(nonatomic, readwrite, assign) NSString *username;
@property(nonatomic, readwrite, assign) NSString *password;

-(void) handleLogin;

@end
