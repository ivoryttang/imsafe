//
//  ProfileView.swift
//  Angel Rings
//
//  Created by Ivory Tang on 11/11/22.
//

import SwiftUI

struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let picture: String
    let relationship: String
    let number: String
}

struct ProfileView: View {
    var username: String
    var date: Date
    
    @State var name: String = ""
    @State var relationship: String = ""
    @State var phonenumber: String = ""
    
    @State var dataArray: [String] = []
    
    var contacts = [
        Contact(name: "Vicky Zheng", picture: "Contact", relationship: "Friend", number: "1234567890")
    ]
    let beige = Color(red: 0.9804, green: 0.9333, blue: 0.7725)
    
    var shape: RoundedRectangle { RoundedRectangle(cornerRadius: 20) }
    var profile: RoundedRectangle { RoundedRectangle(cornerRadius: 10) }
    
    @State private var activated = false
    
    var body: some View {
        ZStack(alignment: .top) {
            beige.ignoresSafeArea()
                .frame(height: 280, alignment: .top)
                .clipShape(shape)
            VStack {
                ZStack {
                    HStack {
                        VStack {
                            Image("User")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                            Button("edit") {}
                                .foregroundColor(.gray)
                        }
                        VStack {
                            Text(username)
                                .font(.system(size: 30))
                            Text("Last checked in at \(date)")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                        }
                    }
                }.padding([.top], 75)
                // emergency contact
                ZStack {
                    VStack(alignment: .leading) {
                        Text("**Contacts**")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        ForEach(contacts.indices) { i in
                            ZStack(alignment: .leading) {
                                Color
                                    .white
                                    .frame(width: 360, height: 150)
                                    .clipShape(shape)
                                    .overlay(
                                        shape.stroke(beige, lineWidth: 2)
                                    )
                                
                                HStack {
                                    Text("\(i+1)")
                                        .foregroundColor(Color(red: 0.9529, green: 0.7961, blue: 0.2706))
                                        .font(.system(size: 25))
                                        .padding([.leading], 10)
                                    Image(contacts[i].picture)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(profile)
                                        .padding([.leading], 10)
                                    VStack(alignment: .leading) {
                                        TextField("Name",text: $name)
                                            .font(.system(size: 20))
                                        TextField("Relationship",text: $relationship)
                                            .foregroundColor(.gray)
                                        TextField("Number",text: $phonenumber)
                                            .foregroundColor(.gray)
                                        Button(action: {if textIsAppropriate(){
                                            saveText()
                                        }}, label: {
                                            Text("Save")
                                                .padding(3)
                                                .background(textIsAppropriate() ? Color.blue:Color.gray)
                                                .cornerRadius(5)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                        })
                                        .disabled(!textIsAppropriate())
                                        
                                    }.padding([.leading], 5)
                                    
                                }
                            }
                        }
                    }
                }.padding([.top], 30) // emergency contact end
                Spacer()
                Button("Log Out") {}
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50)
                    .background(beige)
                    .clipShape(shape)
                    .padding([.bottom], 40)
            }
        }.ignoresSafeArea()
    }
    
    func saveText(){
        dataArray.append(name)
        dataArray.append(relationship)
        dataArray.append(phonenumber)
        print(dataArray)
    }
    func textIsAppropriate() -> Bool {
        if phonenumber.count == 10 && name.count > 0 && relationship.count > 0 {
            return true
        }
        return false
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(username: "", date: Date())
    }
}