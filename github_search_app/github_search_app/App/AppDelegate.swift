//
//  AppDelegate.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupMainWindow()
        
        return true
    }

    private func setupMainWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let mainViewController = ViewController()
            let navigationController = UINavigationController(rootViewController: mainViewController)
            
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
