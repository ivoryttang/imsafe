//
//  MainView.swift
//  imsafe
//
//  Created by Ivory Tang on 11/11/22.
//

import Foundation
import SwiftUI

struct MainView: View {
    @EnvironmentObject var main: Main
    @State private var lastButtonPress = Date()
    
    let beige = Color(red: 0.9804, green: 0.9333, blue: 0.7725)
    
    var body: some View {
        ZStack {
            beige.ignoresSafeArea()
            VStack {
                Text(main.getConfirmationMessage())
                    .font(.system(size: 25))
                ZStack {
                    let buttonSize = 190.0;
                    let shadowSize = 220.0;
                    
                    let (innerCircle, OuterCircle) = main.getColor()
                    
                    OuterCircle
                        .clipShape(Circle())
                        .frame(width: shadowSize, height: shadowSize)
                   
                    Button(main.getState()) {
                        lastButtonPress = Date()
                        main.safetyConfirmed.toggle()
                        let secondsToDelay = 5.0
                        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                            main.safetyConfirmed.toggle()
                        }
                        
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 25))
                    .frame(width: buttonSize, height: buttonSize)
                    .background(innerCircle)
                    .clipShape(Circle())
                    
                }.padding([.top, .bottom], 30)
                Text(main.getCurrentInstructions())
                    .multilineTextAlignment(.center)

            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static let main = Main()
    static var previews: some View {
        MainView().environmentObject(main)
    }
}

