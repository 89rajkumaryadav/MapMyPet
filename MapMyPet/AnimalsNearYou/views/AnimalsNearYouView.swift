//
//  AnimalsNearYouView.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 15/09/26.
//

import SwiftUI


struct AnimalsNearYouView: View {

    @FetchRequest(sortDescriptors: [ NSSortDescriptor(keyPath: \AnimalEntity.id, ascending: true)], animation: .default)
    private var animals: FetchedResults<AnimalEntity>
    @ObservedObject var viewModel: AnimalsNearYouViewModel

  var body: some View {
    NavigationView {
        AnimalListView(animals: animals, footer: {
            if !animals.isEmpty && viewModel.hasMoreAnimals {
                ProgressView("Finding more animals")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .task {
                        await viewModel.fetchMoreAnimals()
                    }
            }
        })
      .task {
          await viewModel.fetchAnimals()
      }
      .listStyle(.plain)
      .navigationTitle("Animals near you")
      .overlay {
          if viewModel.isLoading {
          ProgressView("Finding Animals near you...")
        }
      }
    }.navigationViewStyle(StackNavigationViewStyle())
  }



  @MainActor
  func stopLoading() async {
      viewModel.isLoading = false
  }
}



#Preview {
  //  let animals = Animal.mock
  //  AnimalsNearYouView(animals: Animal.mock, isLoading: false)
}
