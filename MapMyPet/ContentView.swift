//
//  ContentView.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 04/09/26.
//

import SwiftUI
import CoreData
struct ContentView: View {
    let managedObjectContext = PersistenceController.shared.container.viewContext

    var body: some View {
        TabView {
            AnimalsNearYouView(viewModel: AnimalsNearYouViewModel(
                animalFetcher: FetchAnimalsService(requestManager: RequestManager()),
                animalStore: AnimalStoreService(context: PersistenceController.shared.container.newBackgroundContext())
            ))
                .tabItem {
                    Label("Near you", systemImage: "location")
                }.environment(\.managedObjectContext, managedObjectContext)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }.environment(\.managedObjectContext, managedObjectContext)
        }
    }
}

#Preview {
    ContentView()
}

