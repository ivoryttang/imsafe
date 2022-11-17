//
//  imsafeApp.swift
//  imsafe
//
//  Created by Ivory Tang on 11/11/22.
//

import SwiftUI
import GoogleSignIn
import Firebase

@main
struct imsafeApp: App {
    @StateObject var viewModel = AuthenticationViewModel()

    init() {
        setupAuthentication()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(username: "", date: Date()).environmentObject(viewModel)
        }
    }
}

extension imsafeApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}

struct imsafeApp_Previews: PreviewProvider {
    static let main = Main()
    static var previews: some View {
        ContentView(username: "", date: Date())
    }
}
