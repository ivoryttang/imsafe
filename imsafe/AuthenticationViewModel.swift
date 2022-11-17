//
//  AuthenticationViewModel.swift
//  imsafe
//
//  Created by Ivory Tang on 11/15/22.
//

import FirebaseAuth
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {

   
    enum SignInState {
        case signedIn
        case signedOut
    }

    
    @Published var state: SignInState = .signedOut
    @Published var username: String = ""
    
    
    func authenticateUser(for user: GIDUserAuth?, with error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard
            let idToken = user?.user.idToken?.tokenString,
            let accessToken = user?.user.accessToken.tokenString
        else {
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        self.state = .signedIn
        
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                username = user?.user.profile?.name ?? ""
                self.state = .signedIn
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()

        do {
            try Auth.auth().signOut()

            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
