//
//  SearchView.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 15/09/26.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        
        NavigationView {
            Text("Search View")
                .navigationTitle("Find your future pet")
        }.navigationViewStyle(StackNavigationViewStyle())
       
    }
}

#Preview {
    SearchView()
}
