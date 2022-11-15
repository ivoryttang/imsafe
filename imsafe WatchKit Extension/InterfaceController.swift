//
//  InterfaceController.swift
//  imsafe WatchKit Extension
//
//  Created by Ivory Tang on 11/12/22.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var session : WCSession = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        session.delegate = self
        session.activate()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func btnSendToPhont() {
        let dic : [String: Any] = ["watch": "Hello iPhone" as Any]
        session.sendMessage(dic, replyHandler: nil, errorHandler: nil)
    }
    
    //mark:
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
                case .activated:
                    print("WCSession activated successfully")
                case .inactive:
                    print("Unable to activate the WCSession. Error: \(error?.localizedDescription ?? "--")")
                case .notActivated:
                    print("Unexpected .notActivated state received after trying to activate the WCSession")
                @unknown default:
                    print("Unexpected state received after trying to activate the WCSession")
                }
    }
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        print("Message from iPhone: \(message)")
    }
}
