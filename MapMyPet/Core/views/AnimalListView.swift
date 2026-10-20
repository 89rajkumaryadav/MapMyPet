//
//  AnimalListView.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 11/10/26.
//

import SwiftUI

struct AnimalListView<Content, Data>: View
where Content: View,
Data: RandomAccessCollection,
Data.Element: AnimalEntity {
    let animals: Data
    let footer: Content
    let onReachEnd: () -> Void
    
    init(
        animals: Data,
        onReachEnd: @escaping () -> Void = {},
        @ViewBuilder footer: () -> Content
    ) {
        self.animals = animals
        self.onReachEnd = onReachEnd
        self.footer = footer()
    }
    
    init(animals: Data) where Content == EmptyView {
        self.init(animals: animals) {
            EmptyView()
        }
    }
    
    var body: some View {
        List {
            ForEach(animals) { animal in
                NavigationLink(destination: EmptyView()) {
                    AnimalRow(animal: animal)
                }.onAppear(){
                    if animal.id == animals.last?.id {
                        onReachEnd()
                    }
                }
            }
            footer
        }
        .listStyle(.plain)
        
    }
}

#Preview {
    NavigationView {
        AnimalListView(animals: CoreDataHelper.getTestAnimalEntities() ?? [])
    }
    
    NavigationView {
        AnimalListView(animals: []) {
            Text("This is a footer.")
        }
    }
}
