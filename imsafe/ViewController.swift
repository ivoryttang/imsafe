//
//  ViewController.swift
//  imsafe
//
//  Created by Ivory Tang on 11/12/22.
//

import SwiftUI
import WatchConnectivity
class ViewController: UIViewController, WCSessionDelegate {
    
    private var label: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            label.text = "Hello, UIKit!"
            label.textAlignment = .center
            
            return label
        }()
    var session : WCSession?
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
        if WCSession.isSupported(){
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    @objc
    func btnConnectWatch( sender: Any){
        if self.session!.isReachable {
            let dic : [String: Any] = ["iPhoneMsg" : "Hello Watch" as Any]
            self.session!.sendMessage(dic, replyHandler: nil, errorHandler: nil)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        print("Message from watch: \(message)")
        DispatchQueue.main.async {
            if message["watch"] as? String != nil{
                print(message["watch"])
            }
        }
    }
}
