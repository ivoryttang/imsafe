//
//  SearchBar.swift
//  imsafe
//
//  Created by Ivory Tang on 11/21/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isEditing = false
    var body: some View {
        TextField("Search ...", text: $searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .cornerRadius(8)
            .overlay(
                HStack{
                    
                    if isEditing{
                        Button(action: {self.searchText = "Search ..."}){
                            
                        }
                    }
                }
            ).padding(.horizontal, 10)
            .onTapGesture {
                self.isEditing = true
            }
    }
}

/**struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        //SearchBar(searchText: "")
    }
}*/
