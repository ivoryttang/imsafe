//
//  imsafeApp.swift
//  imsafe
//
//  Created by Ivory Tang on 11/11/22.
//

import SwiftUI

@main
struct imsafeApp: App {
    @StateObject private var main = Main()
    
    var body: some Scene {
        WindowGroup {
            LoginView().environmentObject(main)
        }
    }
}

struct imsafeApp_Previews: PreviewProvider {
    static let main = Main()
    static var previews: some View {
        LoginView().environmentObject(main)
    }
}
