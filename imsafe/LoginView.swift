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
import Firebase

struct LoginView: View {
    let beige = Color(red: 0.9804, green: 0.9333, blue: 0.7725)
    let yellow = Color(red: 0.87, green:0.746, blue: 0.266)
    
    @EnvironmentObject var viewModel : AuthenticationViewModel
    @EnvironmentObject var main: Main
    
    
    var body: some View {
        NavigationView{
            ZStack{
                beige.ignoresSafeArea()
                if viewModel.state == .signedIn{
                    ContentView(username: "get username somehow", date: Date())
                }else{
                    VStack(spacing:10){
                        Image("HomeScreen")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(y:-100)
                        GoogleSignInButton(action: handleSignInButton)
                            .padding()
                            .frame(width: 150, height: 50, alignment: .center)
                            .offset(y:-50)
                    }
                }
                
            }
        }
         
    }
    
    func handleSignInButton() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController){ user, error in
                guard let signInUser = user else {
                return
            }
            // Sign in succeeded --> display the app's homepage
            let username = signInUser.user.profile?.name
            viewModel.authenticateUser(for: user, with: error)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

