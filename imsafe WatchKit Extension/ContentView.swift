//
//  ContentView.swift
//  imsafe WatchKit Extension
//
//  Created by Ivory Tang on 11/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var lastButtonPress = Date()
    @State private var isPressed = false
    var body: some View {
        ScrollView{
            VStack {
                Text("Have you safely arrived at your destination?")
                Button("I'm Safe") {
                    // send text to contacts
                    lastButtonPress = Date()
                }.buttonStyle(isPressed ? BorderedButtonStyle(tint: .yellow) : BorderedButtonStyle(tint: .blue)).simultaneousGesture(DragGesture(minimumDistance:0).onChanged({_ in isPressed = true}).onEnded({_ in isPressed = false}))
                    
                Text("\(isPressed ? "Safety Confirmed!" : "Last check-in was at \(lastButtonPress)")")
                
                
            }.navigationTitle("Angel Rings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
