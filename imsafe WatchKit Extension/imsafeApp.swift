//
//  imsafeApp.swift
//  imsafe WatchKit Extension
//
//  Created by Ivory Tang on 11/11/22.
//

import SwiftUI

@main
struct imsafeApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
