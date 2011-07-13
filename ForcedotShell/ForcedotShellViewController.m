//
//  ForcedotShellViewController.m
//  ForcedotShell
//
//  Created by Quinton Wall on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ForcedotShellViewController.h"
#import "Constants.h"

@implementation ForcedotShellViewController

@synthesize webView;

//setting this uses the username and password provided to auto log the user in
@synthesize autoLoginEnabled;
//setting this allows the app to relogin in real time as some changes values in the settings app
//otherwise, the app will stay on the current page until either the app is closed or this toggle is set.
@synthesize fastSwitchingEnabled;

@synthesize loginURL;
@synthesize returnURL;
@synthesize username;
@synthesize password;

- (void)dealloc
{
    [webView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    
   
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setDefaults:) name:NSUserDefaultsDidChangeNotification object:nil];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kAutoLoginEnabled])
        autoLoginEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:kAutoLoginEnabled];
    else
        autoLoginEnabled = YES;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kFastSwitchingEnabled])
        fastSwitchingEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:kFastSwitchingEnabled];
    else
        fastSwitchingEnabled = NO;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kAutoLoginEnabled])
        loginURL = [[NSUserDefaults standardUserDefaults] stringForKey:kLoginURL];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kReturnURL]) 
        returnURL = [[NSUserDefaults standardUserDefaults] stringForKey:kReturnURL];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUsername]) 
        username = [[NSUserDefaults standardUserDefaults] stringForKey:kUsername];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kPassword]) 
        password = [[NSUserDefaults standardUserDefaults] stringForKey:kPassword];
    
    [self handleLogin];
    
	[super viewDidLoad];
}

- (void)viewDidUnload
{
    [webView release];
    webView = nil;
    loginURL = nil;
    returnURL = nil;
    username = nil;
    password = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

//handle the defaults coming from the notification system (in other words, when you change somethign in the 
//settings app
- (void)setDefaults:(NSNotification *)notification {
    
    BOOL newAutoLoginDef = [[NSUserDefaults standardUserDefaults] boolForKey:kAutoLoginEnabled];
    if (autoLoginEnabled != newAutoLoginDef) {
        autoLoginEnabled = newAutoLoginDef;
    }
    
    BOOL newFastSwitchDef = [[NSUserDefaults standardUserDefaults] boolForKey:kFastSwitchingEnabled];
    if (fastSwitchingEnabled != newFastSwitchDef) {
        fastSwitchingEnabled = newFastSwitchDef;
    }
    
    NSString *newLoginUrlDef = [[NSUserDefaults standardUserDefaults] stringForKey:kLoginURL];
    if (![loginURL isEqualToString:newLoginUrlDef]) {
        loginURL = newLoginUrlDef;
    }
    
    NSString *newUsernameDef = [[NSUserDefaults standardUserDefaults] stringForKey:kUsername];
    if (![username isEqualToString:newUsernameDef]) {
        username = newUsernameDef;
    }
    
    NSString *newReturnURLDef = [[NSUserDefaults standardUserDefaults] stringForKey:kReturnURL];
    if (![returnURL isEqualToString:newReturnURLDef]) {
        returnURL = newReturnURLDef;
    }
    
    NSString *newPasswordDef = [[NSUserDefaults standardUserDefaults] stringForKey:kPassword];
    if (![password isEqualToString:newPasswordDef]) {
        password = newPasswordDef;
    }
    
    
    //fast switching means real time reloads when someone makes an update to the settings of the app
    if (fastSwitchingEnabled) {
         [self handleLogin];
    }
}

-(void) handleLogin {
    
   // NSLog (@"----> %@", loginURL);
    //NSLog (@"----> %@", username);
    //NSLog (@"----> %@", password);
    //NSLog (@"----> %@", returnURL);
    
    NSString *urlAddress = @"";
    
    if (loginURL == NULL) {
        loginURL = @"https://login.salesforce.com";
    }
    
    if(!autoLoginEnabled) {
        urlAddress = loginURL;
    }
    else
    {
        if(returnURL != NULL) {
             urlAddress = [NSString stringWithFormat:@"%@?startURL=%@&un=%@&pw=%@", loginURL, returnURL, username, password];
        }
        else if(username != NULL || password || NULL) {
            urlAddress = [NSString stringWithFormat:@"%@?un=%@&pw=%@", loginURL, username, password];
        }
        else {
            //in case something messed up, lets default to autologin url.
            urlAddress = loginURL;
        }
                
    }
    
    
    
    NSLog (@"----> %@", urlAddress);
	//Create a URL object.
	NSURL *url = [NSURL URLWithString:urlAddress];
    
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
	//Load the request in the UIWebView.
	[webView loadRequest:requestObj];

}

@end
