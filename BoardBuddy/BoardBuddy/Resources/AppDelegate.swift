//
//  AppDelegate.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        turnOnSleepMode()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        turnOffSleepMode()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        turnOnSleepMode()
    }
    
    func turnOffSleepMode() {
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func turnOnSleepMode() {
        UIApplication.shared.isIdleTimerDisabled = false
    }
}

