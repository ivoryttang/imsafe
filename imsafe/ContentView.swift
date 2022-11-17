//
//  ContentView.swift
//  imsafe
//
//  Created by Ivory Tang on 11/11/22.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    var username: String
    var date: Date
    @EnvironmentObject var viewModel : AuthenticationViewModel
    @StateObject var main = Main()
    
    
    var body: some View {
        switch viewModel.state {
            case .signedIn:
                VStack{
                    TabView {
                        MainView().environmentObject(main).tabItem {}
                        ProfileView(username: username, date: date).tabItem {}
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                    .edgesIgnoringSafeArea(.all)
                }
            case .signedOut:
                VStack{
                    LoginView().environmentObject(viewModel)
                }
        }
         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(username:"", date: Date())
    }
}
