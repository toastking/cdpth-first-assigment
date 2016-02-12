//
//  AppDelegate.swift
//  Movie App
//
//  Created by Matt on 1/29/16.
//  Copyright © 2016 Matt Del Signore. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //programatically make the tab bar for the app
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nowPlayingNavController = storyboard.instantiateViewControllerWithIdentifier("moviesNavigationController") as! UINavigationController
        let nowPlayingViewController = nowPlayingNavController.topViewController as! MoviesViewController
        nowPlayingViewController.endpt = "now_playing"
        
        //set the tab bar item stuff
        nowPlayingNavController.tabBarItem.title = "Now Playing"
        nowPlayingNavController.tabBarItem.image = UIImage(named: "nowplaying")
        
        let topRatedNavController = storyboard.instantiateViewControllerWithIdentifier("moviesNavigationController") as! UINavigationController
        let topRatedViewController = topRatedNavController.topViewController as! MoviesViewController
        topRatedViewController.endpt = "top_rated"
        
        
        //tab bar item
        topRatedNavController.tabBarItem.title = "Top Rated"
        topRatedNavController.tabBarItem.image = UIImage(named: "toprated")
        
        //now that the view controllers are made we need to initalize the tab bar
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nowPlayingNavController,topRatedNavController]
        
        //add the tab bar to the window
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        // Override point for customization after application launch.
        return true
    }

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


}

