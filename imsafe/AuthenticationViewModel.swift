//
//  AuthenticationViewModel.swift
//  imsafe
//
//  Created by Ivory Tang on 11/15/22.
//

import Firebase
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {

   
    enum SignInState {
        case signedIn
        case signedOut
    }

    
    @Published var state: SignInState = .signedOut
    
    

}
