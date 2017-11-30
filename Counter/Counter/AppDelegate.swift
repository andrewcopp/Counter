//
//  AppDelegate.swift
//  Counter
//
//  Created by Andrew Copp on 11/29/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let coreData: CoreData = CoreData()
        
        let interactor: CountInteractor = CountInteractor(coreData: coreData)
        let presenter: CountPresenter = CountPresenter(interactor: interactor)
        let viewController: UIViewController = CountViewController(presenter: presenter)
        
        let window: UIWindow = UIWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
}

