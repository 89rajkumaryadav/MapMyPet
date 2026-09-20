//
//  AnimalsNearYouView.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 15/09/26.
//

import SwiftUI


struct AnimalsNearYouView: View {
  @State var animals: [Animal] = []
  @State var isLoading = true
  private let requestManager = RequestManager()

  var body: some View {
    NavigationView {
      List {
        ForEach(animals) { animal in
          AnimalRow(animal: animal)
        }
      }
      .task {
        await fetchAnimals()
      }
      .listStyle(.plain)
      .navigationTitle("Animals near you")
      .overlay {
        if isLoading {
          ProgressView("Finding Animals near you...")
        }
      }
    }.navigationViewStyle(StackNavigationViewStyle())
  }

  func fetchAnimals() async {
    do {
      let animalsContainer: AnimalsContainer = try await requestManager.perform(AnimalsRequest.getAnimalsWith(page: 1))
        let animals = animalsContainer.data
      self.animals = animals
      await stopLoading()
    } catch {
    }
  }

  @MainActor
  func stopLoading() async {
    isLoading = false
  }
}



#Preview {
    AnimalsNearYouView(animals: Animal.mock, isLoading: false)
}
