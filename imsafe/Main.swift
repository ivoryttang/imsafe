//
//  Main.swift
//  imsafe
//
//  Created by Ivory Tang on 11/11/22.
//

import Foundation
import SwiftUI

class Main: ObservableObject {

     @Published var safetyConfirmed = false

    func getConfirmationMessage() -> String {
        return safetyConfirmed ? "Congrats!" : "Have you safely arrived at your destination?"
    }
    
    func getState() -> String {
        return safetyConfirmed ? "Safety Confirmed" : "I'm Safe!"
    }

    func getColor() -> (Color, Color) {
        if safetyConfirmed {
            return (Color(red: 0.9529, green: 0.7960, blue: 0.2706), Color(red: 0.9686, green: 0.8863, blue: 0.6039))
        } else {
            return (Color.white, Color(red: 0.9922, green: 0.9686, blue: 0.8863))
        }
    }
    
    
    func getCurrentInstructions() -> String {
        if safetyConfirmed {
            return "Your status has been sent to your contacts. You will be redirected to the previous page in 5 seconds."
        } else {
            return "Tap to let your contacts know you're safe and end planned trip."
        }
    }
}


