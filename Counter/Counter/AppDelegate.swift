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
        let http: HTTP = HTTP()
        
        let countFactory: CountFactory = CountFactory(coreData: coreData)
        
        let listInteractor: ListInteractor = ListInteractor(coreData: coreData, http: http)
        let listPresenter: ListPresenter = ListPresenter(interactor: listInteractor)
        let listViewController: ListViewController = ListViewController(presenter: listPresenter, countFactory: countFactory)
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: listViewController)
        
        let window: UIWindow = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
}

