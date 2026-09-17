//
//  ContentView.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 04/09/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AnimalsNearYouView()
                .tabItem {
                    Label("Near you", systemImage: "location")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ContentView()
}

