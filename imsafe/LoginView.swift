//
//  ContentView.swift
//  imsafe
//
//  Created by Ivory Tang on 11/11/22.
//

import SwiftUI

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
                Picker(selection: $isLoginMode, label: Text("Picker here")){
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                
                if isLoginMode{
                    TextField("Username", text: $username).padding()
                        .frame(width: 300, height: 50).background(Color.black.opacity(0.2)).cornerRadius(10).border(.red, width:CGFloat(wrongUsername))
                    SecureField("Password", text: $password).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.2)).cornerRadius(10).border(.red, width:CGFloat(wrongPassword))
                    Button("Login"){
                        authenticateUser(username:username, password:password)
                    }.foregroundColor(.white).frame(width: 300, height: 50).background(yellow).cornerRadius(10)
                        
                    NavigationLink(destination: ContentView(username: username, date: Date()),isActive: $showingLoginScreen){
                    }
                }else{
                    TextField("Username", text: $username).padding()
                        .frame(width: 300, height: 50).background(Color.black.opacity(0.2)).cornerRadius(10).border(.red, width:CGFloat(wrongUsername))
                    TextField("Email", text: $email).padding()
                        .frame(width: 300, height: 50).background(Color.black.opacity(0.2)).cornerRadius(10)
                    SecureField("Password", text: $password).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.2)).cornerRadius(10).border(.red, width:CGFloat(wrongPassword))
                    SecureField("Confirm Password", text: $password).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.2)).cornerRadius(10).border(.red, width:CGFloat(wrongPassword))
                    Button("Create Account"){
                        authenticateUser(username:username, password:password)
                    }.foregroundColor(.white).frame(width: 300, height: 50).background(yellow).cornerRadius(10)
                }
                    
                }
            }
        }
         
    }
    
    func handleCreateAccount() {
            //firebase auth
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

