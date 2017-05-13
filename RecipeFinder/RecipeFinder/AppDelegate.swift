//
//  AppDelegate.swift
//  RecipeFinder
//
//  Created by Sismanidis, Evangelos (415) on 13.05.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.black
        
        let nvc = UINavigationController(rootViewController: RecipeViewController())
        window!.rootViewController = nvc
        
        window!.makeKeyAndVisible()
        return true
    }
}

