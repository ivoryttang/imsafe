//
//  PresetView.swift
//  imsafe
//
//  Created by Ivory Tang on 11/21/22.
//

import SwiftUI

struct PresetView: View {
    @State var chosenDate = Date()
    @State private var showPicker = false
    var body: some View {
        let beige = Color(red: 0.9804, green: 0.9333, blue: 0.7725)
        let yellow = Color(red: 0.87, green:0.746, blue: 0.266)
        
        ZStack{
            beige.ignoresSafeArea()
            VStack(alignment: .center, spacing: 50){
                Text("Write down your plan before you leave").bold().font(.largeTitle).frame(width: 400, height: 100, alignment: .center)
                Text("If you are not back according to plan, your contacts will be automatically notified.").frame(width: 400, height: 50, alignment: .center).font(.caption)
                HStack{
                    Text("I’m going to ").padding().font(.title2).background(.white).cornerRadius(20)
                    Menu {
                        Text("Go for a walk")
                        Text("Meet with a friend")
                        Text("Go to work")
                        Text("Go on a date")
                        Text("Add new activity")
                    } label: {
                         Text("Choose Activity")
                    }.padding().font(.title2).background(.white).cornerRadius(20)
                }
                HStack{
                    Text("and will return to ").padding().font(.title2).background(.white).cornerRadius(20)
                    Button(action: {self.showPicker.toggle()}){
                        Text("Location").padding().font(.title2).background(.white).cornerRadius(20)
                    }.sheet(isPresented: self.$showPicker){
                        PlacePickerView(showModel: self.$showPicker, viewModel: PlacePickerViewModel())
                    }
                }
                
                HStack{
                    Text("by").padding().font(.title2).background(.white).cornerRadius(20)
                    DatePicker("Please enter a date", selection: $chosenDate, in: Date.now...).padding().font(.caption2).background(.white).cornerRadius(20)
                }.frame(width: 250, height: 60, alignment: .center)
                
                Button(action:{self.showPicker.toggle()}){
                    Text("Save Plan")
                }.padding().foregroundColor(.white).font(.title2).background(yellow).cornerRadius(20)
            }
            
        }
    }
}

struct PresetView_Previews: PreviewProvider {
    static var previews: some View {
        PresetView()
    }
}
