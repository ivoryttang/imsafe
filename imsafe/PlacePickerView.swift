//
//  PlacePickerView.swift
//  imsafe
//
//  Created by Ivory Tang on 11/21/22.
//

import SwiftUI
import CoreLocation

final class PlacePickerViewModel: ObservableObject{
    private let locationManager = CLLocationManager()
    private var searchDistance: Double = 1000
    private var defaultSearchCoordinate: CLLocationCoordinate2D?
    @Published var searchText = ""
    
    //init(
        
    //)
}
struct PlacePickerView: View {
    
    @Binding var showModel: Bool
    @ObservedObject var viewModel: PlacePickerViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(searchText: $viewModel.searchText).padding(.top, 8)
            }.navigationTitle("Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {self.showModel.toggle()}){
                        Text("X")
                    }
                }
            }
        }
    }
}

/**struct PlacePickerView_Previews: PreviewProvider {
    static var previews: some View {
        PlacePickerView(showModel: false)
    }
}*/
