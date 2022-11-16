//
//  AppDelegate.swift
//  imsafe
//
//  Created by Ivory Tang on 11/15/22.
//

import GoogleSignIn
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
              // Show the app's signed-out state.
               
            } else {
              // Show the app's signed-in state.
               
            }
        }
        return true
    }
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
       
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    
}

