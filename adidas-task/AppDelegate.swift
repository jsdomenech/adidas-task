//
//  AppDelegate.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let dependencyContainer = AppDependencyContainer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = dependencyContainer.makeMainViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

