//
//  AppDelegate.swift
//  Discipline
//
//  Created by Shannon Layden on 8/22/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import UIKit
import Material

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        updateNavBarLook()
        updateStatusBar()
        return true
    }
    
    
    func updateNavBarLook() {
        let navAppearance = UINavigationBar.appearance()
        navAppearance.barTintColor = MaterialColor.blue.base
        navAppearance.tintColor = MaterialColor.white
        navAppearance.titleTextAttributes = [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light" as String, size: 0)!,NSForegroundColorAttributeName: UIColor.whiteColor()]
        
    }
    
    func updateStatusBar()
    {
    
    UIApplication.sharedApplication().statusBarStyle = .LightContent
        let statusBar: UIView = UIApplication.sharedApplication().valueForKey("statusBar") as! UIView
        if statusBar.respondsToSelector(Selector("setBackgroundColor:")) {
            statusBar.backgroundColor = MaterialColor.blue.darken1
        }
        
    
    }
    
    
    
    /*
 NSShadow *shadow = [[NSShadow alloc] init];
 shadow.shadowColor = [UIColor blackColor];
 shadow.shadowBlurRadius = 0.0;
 shadow.shadowOffset = CGSizeMake(0.0, 2.0);
 [[UINavigationBar appearance] setTitleTextAttributes: @{
 NSForegroundColorAttributeName : [UIColor blackColor],
 NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:0.0f],
 NSShadowAttributeName : shadow
 }];
 */

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }

}

