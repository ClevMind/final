//
//  AppDelegate.m
//  BTGlassScrollViewExample2
//
//  Created by Byte on 1/23/14.
//  Copyright (c) 2014 Byte. All rights reserved.
//

#import "AppDelegate.h"

#define NUMBER_OF_PAGES 5
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]


@implementation AppDelegate
{
    NSMutableArray *_viewControllerArray;
    int _currentIndex;
    CGFloat _glassScrollOffset;
}

@synthesize reachability;
@synthesize NET;
@synthesize FORECAST;
@synthesize updateTimer;
@synthesize date;
@synthesize dateFormat;
@synthesize dateString;


- (id)init {
    self = [super init];
    
    if (self) {
        NET = [_rp5_NET new];
        
        // initialized = 1;
        
    }
    
    return self;
}


- (void) reachabilityChanged:(NSNotification *)notice
{
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    NET.reachability = reachability;
    
    if(remoteHostStatus == NotReachable) {
        [NET isUnreachable];
    }
    else if (remoteHostStatus == ReachableViaWiFi) {
        //[MAIN loadingStart];
        [FORECAST getWeather:@"NOW"];
        [NET isReachableViaWiFi];
    }
    else if (remoteHostStatus == ReachableViaWWAN) {
        // [MAIN loadingStart];
        [FORECAST getWeather:@"NOW"];
        [NET isReachableViaWWAN];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    reachability = [Reachability reachabilityForInternetConnection]; //retain reach
    [reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    [NSTimer scheduledTimerWithTimeInterval:UPDATE_INTERVAL
                                     target:self
                                   selector:@selector(Update)
                                   userInfo:nil
                                    repeats:YES];
    
     dateFormat = [[NSDateFormatter alloc] init];
    /*[NSTimer scheduledTimerWithTimeInterval:10.0f
     target:self
     selector:@selector(NotifyMe)
     userInfo:nil
     repeats:YES];*/
    
    // MAIN = (MainViewController*)  self.window.rootViewController;
    FORECAST = [_rp5_forecast new];
    _rp5_geo *GEO = [_rp5_geo new];
    
    
    
    if(remoteHostStatus == ReachableViaWiFi || remoteHostStatus == ReachableViaWWAN) {
        
        [NET isReachable];
        [FORECAST getWeather:@"NOW"];
        //[FORECAST deleteForecast];
        //≥NSLog(@"YESSSSB");
        // [NET isUnreachable];
        // [MAIN setDefault:FORECAST];
        
        // NSLog(@"init **** Not Reachable ****");
    } else {
        [NET isUnreachable];
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    _viewControllerArray = [NSMutableArray array];
    UINavigationController *glassScrollVCWithNavC = [self glassScrollVCWithNavigatorForIndex:0];
    _viewControllerArray[0] = glassScrollVCWithNavC;
    
    
    NSDictionary* options = @{ UIPageViewControllerOptionInterPageSpacingKey : [NSNumber numberWithFloat:4.0f] };

    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    [pageViewController setViewControllers:_viewControllerArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [pageViewController.view setBackgroundColor:[UIColor blackColor]];
    [pageViewController setDelegate:self];
    [pageViewController setDataSource:self];
    
    
    // THIS IS A HACK INTO THE PAGEVIEWCONTROLLER
    // PROCEED WITH CAUTION
    // MAY CONTAIN BUG!! (I HAVENT RAN INTO ONE YET)
    // looking for the subview that is a scrollview so we can attach a delegate onto the view to mornitor scrolling
    for (UIView *subview in pageViewController.view.subviews) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollview = (UIScrollView *) subview;
            [scrollview setDelegate:self];
        }
    }
    
    self.window.rootViewController = pageViewController;
    return YES;
}



- (void)weatherUpdataNow:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"Here we go!");
    
    if(error && ![error isKindOfClass:[NSNull class]]) {
        NSLog(@"Ошибка в подключении!Проверьте соединение");
        exit(1);
    }
    
    // NSLog(@"%@", [[[[json objectForKey:@"response"] objectForKey:@"current_weather"] objectForKey:@"feel_temperature"] objectForKey:@"c"]);
    
    
    //JsonCurrWeather = ;
    
    // NSLog(@"%@", [[JsonCurrWeather objectForKey:@"feel_temperature"] objectForKey:@"c"]);
    
    // NSMutableDictionary *weather_now = [NSMutableDictionary new];
    //weather_now =
    /*MAIN.current_temp.text = [json objectForKey:@"t"];
     MAIN.feel_like_temp.text = [NSString stringWithFormat:@"%@", [json objectForKey:@"feel"]];
     
     MAIN.archive.text = [NSString stringWithFormat:@"%@", [json objectForKey:@"archive"]];
     MAIN.archive.textColor = [UIColor whiteColor];
     [MAIN.archive setFont: [UIFont fontWithName:@"ArialMT" size:20]];
     
     */
    date = [NSDate date];
    [dateFormat setDateFormat:@"dd.MM HH:mm:ss"];
    //  MAIN.update_time_value.text  = [dateFormat stringFromDate:date];*/
    
    //NSLog(@"TIME:  %@", [dateFormat stringFromDate:date]);
    
    
    
    NSMutableDictionary *weather_now = [NSMutableDictionary new];
    [weather_now setObject:[[json objectForKey:@"response"] objectForKey:@"local_time"]                                                               forKey:@"local_time"];
    [weather_now setObject:[[json objectForKey:@"response"] objectForKey:@"created"]                                                                  forKey:@"update_time"];
    [weather_now setObject:[dateFormat stringFromDate:date]                                                                                           forKey:@"local_update_time"];
    [weather_now setObject:[[[[json objectForKey:@"response"] objectForKey:@"current_weather"] objectForKey:@"temperature"] objectForKey:@"c"]        forKey:@"t_c"];
    [weather_now setObject:[[[[json objectForKey:@"response"] objectForKey:@"current_weather"] objectForKey:@"temperature"] objectForKey:@"f"]        forKey:@"t_f"];
    [weather_now setObject:[[[[json objectForKey:@"response"] objectForKey:@"current_weather"] objectForKey:@"feel_temperature"] objectForKey:@"c"]   forKey:@"feel_t_c"];
    [weather_now setObject:[[[[json objectForKey:@"response"] objectForKey:@"current_weather"] objectForKey:@"feel_temperature"] objectForKey:@"f"]   forKey:@"feel_t_f"];
    [weather_now setObject:[[[[json objectForKey:@"response"] objectForKey:@"current_weather"] objectForKey:@"wind_velocity"] objectForKey:@"ms"]     forKey:@"wind_ms"];
    NSString *archiveStr = [NSString stringWithFormat:@"%@", [[[json objectForKey:@"response"]  objectForKey:@"current_weather"] objectForKey:@"archive_string"]];
    archiveStr = [archiveStr stringByReplacingOccurrencesOfString:@"#t"
                                                       withString:[NSString stringWithFormat:@"%@ °C",[weather_now objectForKey:@"feel_t_c"]]];
    
    archiveStr = [archiveStr stringByReplacingOccurrencesOfString:@"#wv"
                                                       withString:[NSString stringWithFormat:@"(%@ м/с)",[weather_now objectForKey:@"wind_ms"]]];
    
    [weather_now setObject:archiveStr                        forKey:@"archive"];
    
    
    /*           РАСШИФРОВКА ВРЕМЕНИ ЮНИКС   */
    // NSDate *date2 = [NSDate dateWithTimeIntervalSince1970: [[weather_now objectForKey:@"update_time"] doubleValue]];
    // NSLog(@"BTCH  %@",[date2 description]);
    /*           РАСШИФРОВКА ВРЕМЕНИ ЮНИКС   */
    
    
    NSMutableDictionary *current_town_forecast = [NSMutableDictionary new];
    [current_town_forecast setObject:@"Симферополь"             forKey:@"town_name"];
    //  [current_town_forecast setObject:@"" forKey:]
    [current_town_forecast setObject:weather_now                forKey:@"weather_now"];
    
    
    
   UILabel *CurrTemp = [self.window.rootViewController.view viewWithTag:7];
    
    CurrTemp.text = [NSString stringWithFormat:@"%@°",[weather_now objectForKey:@"t_c"]];
    
    if([FORECAST saveForecast:current_town_forecast]) {
        NSLog(@"Saved!");
    } else {
        NSLog(@"Error Saving!");
    }
    // [FORECAST deleteForecast];
    /*
     
     NSFileManager *filemgr;
     filemgr = [NSFileManager defaultManager];
     NSArray *filelist = [filemgr contentsOfDirectoryAtPath:get_path() error:NULL];
     int count = [filelist count];
     int  i;
     
     for (i = 0; i < count; i++)
     NSLog(@"FILE: %@", filelist[i]);
     
     
     
     user_town.text = [NSString stringWithFormat:@"Погода в %@", [json objectForKey:@"city"]];
     NSString *archiveData = [json objectForKey:@"archive"];
     NSLog(@"%@", archiveData);
     temp_now.text = [json objectForKey:@"t"];
     // feel_temp.text = [data objectForKey:@"feel"];
     archive.text = archiveData;*/
    
}


- (void) Update {
    [self updateTime];
    if(!NET.isOFF) {
        [FORECAST getWeather:@"NOW"];
        NSLog(@"TimerUpdate!");
    }
}

- (void) updateTime {
    date = [NSDate date];
    [dateFormat setDateFormat:@"HH:mm"];
    // MAIN.current_time.text = [dateFormat stringFromDate:date];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if(!NET.isOFF) {
        [FORECAST getWeather:@"NOW"];
    }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Delegate & Datasource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    BTGlassScrollViewController *currentGlass = ((BTGlassScrollViewController*)(((UINavigationController *)viewController).viewControllers)[0]);
    _currentIndex = currentGlass.index;
    int replacementIndex = _currentIndex - 1;
    
    if (replacementIndex < 0) {
        return nil;
    }
    
    return _viewControllerArray[replacementIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    BTGlassScrollViewController *currentGlass = (BTGlassScrollViewController*)(((UINavigationController *)viewController).viewControllers)[0];
    _currentIndex = currentGlass.index;
    int replacementIndex = _currentIndex + 1;
    
    if (replacementIndex == NUMBER_OF_PAGES) {
        return nil;
    }
    
    UINavigationController *replacementViewController;
    if (_viewControllerArray.count == replacementIndex) {
        replacementViewController = [self glassScrollVCWithNavigatorForIndex:replacementIndex];
        _viewControllerArray[replacementIndex] = replacementViewController;
    } else {
        replacementViewController = _viewControllerArray[replacementIndex];
    }
    return replacementViewController;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    UINavigationController *navVC = _viewControllerArray[_currentIndex];
    BTGlassScrollViewController *glassVC = navVC.viewControllers[0];
    
    UINavigationController *pendingNavVC = pendingViewControllers[0];
    BTGlassScrollViewController *pendingGlassVC = pendingNavVC.viewControllers[0];
    
    [pendingGlassVC.glassScrollView scrollVerticallyToOffset:glassVC.glassScrollView.foregroundScrollView.contentOffset.y];
    
    //this is a hack to make sure the blur does exactly what it should do
    if (glassVC.glassScrollView.foregroundScrollView.contentOffset.y > 0) {
        [pendingGlassVC.glassScrollView blurBackground:YES];
    }
}

#pragma mark UIScrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // This is a custom ScrollView (private to Apple)
    // I found that they resets the scrolling everytime the viewController comes to rest
    // it rests at 360 (or width), left scroll causes it to decrease, right causes increase
    
    CGFloat ratio = (scrollView.contentOffset.x / scrollView.frame.size.width) - 1;
    
    
    // prevent any crazy behaviour due to lag
    // sometimes it resets itself when comes to reset and show crazy jumps
    if (ratio == 0) {
        return;
    }

    // retrieve views with index and +/- 1
    [((BTGlassScrollViewController*)(((UINavigationController *)_viewControllerArray[_currentIndex]).viewControllers)[0]).glassScrollView scrollHorizontalRatio:-ratio];
    
    if (_currentIndex != 0) {
        // do the previous scroll
        [((BTGlassScrollViewController*)(((UINavigationController *)_viewControllerArray[_currentIndex - 1]).viewControllers)[0]).glassScrollView scrollHorizontalRatio:-ratio-1];
    }
    
    if (_currentIndex != (_viewControllerArray.count - 1)) {
        // do the next scroll
        [((BTGlassScrollViewController*)(((UINavigationController *)_viewControllerArray[_currentIndex + 1]).viewControllers)[0]).glassScrollView scrollHorizontalRatio:-ratio+1];
    }

}

#pragma mark - Make views
// This method is useful when you want navigation bar, Otherwise return BTGlassScrollViewController object instead
- (UINavigationController *)glassScrollVCWithNavigatorForIndex:(int)index
{
    //Here is where you create your next view!
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: [self glassScrollViewControllerForIndex:index]];
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(1, 1)];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowBlurRadius:1];
    navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSShadowAttributeName: shadow};

    //weird voodoo to remove navigation bar background
    [navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationController.navigationBar setShadowImage:[UIImage new]];
    
    return navigationController;
}

- (BTGlassScrollViewController *)glassScrollViewControllerForIndex:(int)index
{
    // This is just an example for a glassScrollViewController set up
    BTGlassScrollViewController *glassScrollViewController = [[BTGlassScrollViewController alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"background%i",index%2?2:3]]];
    [glassScrollViewController setTitle:[NSString stringWithFormat:@"Simferopol #%i", index]];
    [glassScrollViewController setIndex:index];
    return glassScrollViewController;
}

@end
