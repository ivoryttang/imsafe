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
    
    var body: some View {
        
        
        TabView {
            MainView().tabItem {}
            ProfileView(username: username, date: date).tabItem {}
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        .edgesIgnoringSafeArea(.all)
         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(username:"", date: Date())
    }
}
