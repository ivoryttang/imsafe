//
//  imsafeApp.swift
//  imsafe
//
//  Created by Ivory Tang on 11/11/22.
//

import SwiftUI
import GoogleSignIn
import FirebaseCore

@main
struct imsafeApp: App {
    
    @StateObject private var main = Main()
    
    var body: some Scene {
        WindowGroup {
            LoginView().environmentObject(main)
                .onAppear {
                    FirebaseApp.configure()
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                    // Check if `user` exists; otherwise, do something with `error`
                    }
                }
        }
    }
}

struct imsafeApp_Previews: PreviewProvider {
    static let main = Main()
    static var previews: some View {
        LoginView().environmentObject(main)
    }
}
