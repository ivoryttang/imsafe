//
//  MainView.swift
//  imsafe
//
//  Created by Ivory Tang on 11/11/22.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    let url = URL(string: "https://console.cloud.google.com/storage/browser/imsafe_location_tracking")

        
    func requestLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("So failed: \(error)")
    }
    
    func sendPUT() {
        var request = URLRequest(url: url!)
        request.setValue("Bearer " + "ya29.a0AeTM1icuG9QEFmXthsHOO0rvlB9AghSv6f7qamCq7UM4fEFB9qLtwE-636KPqEdpFfMmWCnH8_DuW6PxBnpf2J3HthQM7ILkpFi2OADb_vtbJXHlaL-IvwrH-XiTdjD051znBWpwlnuIyoLcFslbkTM4vbCUaCgYKAdASARISFQHWtWOmFxaYXfcbUMCkBlT557RkIw0163", forHTTPHeaderField: "Authorization")
        
        // Serialize HTTP Body data as JSON
        let body = ["location": location]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )

        // Change the URLRequest to a PUT request
        request.httpMethod = "PUT"
        request.httpBody = bodyData
        
        print(request.allHTTPHeaderFields!)
        
        // Create the HTTP request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in

            if let error = error {
                print("HTTP POST request error: \(error)")
            } else if data != nil {
                print("HTTP POST response: \(response!.description)")
            } else {
                print("HTTP POST request error")
            }
        }
        
        task.resume()
    }
}

struct MainView: View {
    @EnvironmentObject var main: Main
    @EnvironmentObject var viewModel : AuthenticationViewModel
    @State private var lastButtonPress = Date()
    @StateObject var locationManager = LocationDataManager()
    
    let beige = Color(red: 0.9804, green: 0.9333, blue: 0.7725)
    let center = UNUserNotificationCenter.current()
    
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
                        locationManager.requestLocation()
                        locationManager.sendPUT()
                        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                            
                            if let error = error {
                                // Handle the error here.
                            }
                            
                            // Enable or disable features based on the authorization.
                        }
                        let content = UNMutableNotificationContent()
                        content.title = "Location Update"
                        content.body = viewModel.username + " has confirmed their safety"
                        let uuidString = UUID().uuidString
                        var date = DateComponents()
                        date.hour = 17
                        date.minute = 3
                        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
                        let request = UNNotificationRequest(identifier: uuidString,
                                    content: content, trigger: trigger)

                        // Schedule the request with the system.
                        let notificationCenter = UNUserNotificationCenter.current()
                        notificationCenter.add(request) { (error) in
                           if error != nil {
                              // Handle any errors.
                           }
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
                if let location = locationManager.location {
                    Text("Your location: \(location.latitude), \(location.longitude)")
                }
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

