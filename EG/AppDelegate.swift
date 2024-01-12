//
//  AppDelegate.swift
//  EG
//
//  Created by MACPRO-108 on 16/12/23.
//

import UIKit
import SwiftyJSON
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?
    var navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        self.initalvc(vc: firstVC())

        return true
    }
    
    func initalvc(vc:UIViewController) {
        
        let window = UIWindow()
        self.window = window
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        
    }
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

