//
//  AuthenticationViewModel.swift
//  imsafe
//
//  Created by Ivory Tang on 11/15/22.
//

import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase

class AuthenticationViewModel: ObservableObject {

   
    enum SignInState {
        case signedIn
        case signedOut
    }

    
    @Published var state: SignInState = .signedOut
    @Published var username: String = ""
    @Published var email: String = ""
    
    var ref: DatabaseReference = Database.database().reference()
    
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
        
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                username = user?.user.profile?.name ?? ""
                email = user?.user.profile?.email ?? "unknown"
                print(email)
                self.state = .signedIn
                self.ref.child("users/").updateChildValues([username:email])
                self.ref.child("alerts/").updateChildValues([username:false])
                
                //only add member to contacts if user not existing already, otherwise will overwrite
                ref.child("contacts/saving-contact-info/\(username)").getData(completion:  { error, snapshot in
                  guard error == nil else {
                    print(error!.localizedDescription)
                    self.ref.child("contacts/saving-contact-info/").updateChildValues([username:""])
                    return;
                  }
                });
                
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
