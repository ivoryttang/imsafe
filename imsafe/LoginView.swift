//
//  ContentView.swift
//  imsafe
//
//  Created by Ivory Tang on 11/11/22.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn
import FirebaseCore

struct LoginView: View {
    let beige = Color(red: 0.9804, green: 0.9333, blue: 0.7725)
    let yellow = Color(red: 0.87, green:0.746, blue: 0.266)
    
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State var wrongUsername = 0
    @State var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var isLoginMode = true
    
    var body: some View {
        NavigationView{
            ZStack{
                beige.ignoresSafeArea()
                VStack(spacing:10){
                    Image("HomeScreen")
                                .resizable()
                                .scaledToFit()
                                .offset(y:-100)
                    GoogleSignInButton(action: handleSignInButton).padding().frame(width: 150, height: 50, alignment: .center).offset(y:-50)
                }
            }
        }
         
    }
    
    func handleSignInButton() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
        
    }
    
    func authenticateUser(username: String, password: String){
        if username.lowercased() == "ivory"{
            wrongUsername = 0
            if password.lowercased() == "tang"{
                wrongPassword = 0
                showingLoginScreen = true
            }else{
                wrongPassword = 2
            }
        }else{
            wrongUsername = 2
        }
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

