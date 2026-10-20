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
        AnimalListView(animals: animals,
                       onReachEnd: {
            Task {
                                await viewModel.fetchMoreAnimals()
                            }
        },
                       
                       footer: {
            if viewModel.isInitialLoadingDone,viewModel.isMoreAnimalAvailable {
                paginationFooter
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

    @ViewBuilder
    private var paginationFooter: some View {
        if viewModel.isLoadingMore {
            ProgressView("Finding more animals...")
                .frame(maxWidth: .infinity)
                .padding()
        } else if let error = viewModel.errorMessage {
            VStack(spacing: 8) {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Button("Retry") {
                    Task {
                        await viewModel.fetchMoreAnimals()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }

   }

#Preview {
  //  let animals = Animal.mock
  //  AnimalsNearYouView(animals: Animal.mock, isLoading: false)
}
