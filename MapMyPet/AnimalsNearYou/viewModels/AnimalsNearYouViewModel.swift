//
//  AnimalsNearYouViewModel.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 11/10/26.
//

import Foundation
internal import Combine

protocol AnimalsFetcher {
    func fetchAnimals(page: Int, limit: Int) async -> [Animal]
}

protocol AnimalStore {
    func save(animals: [Animal]) async throws
}


@MainActor
final class AnimalsNearYouViewModel: ObservableObject {
    
    enum LoadingState: Equatable {
        case idle
        case loading
        case loaded
        case failed(String)
        case isLoadingMore
    }
    
    @Published private(set) var loadingState: LoadingState = .idle
    private(set) var isMoreAnimalAvailable = true
    private(set) var isInitialLoadingDone = false
     
    
    
    private let animalFetcher: AnimalsFetcher
    private let animalStore: AnimalStore

    private(set) var page = 1

    init(animalFetcher: AnimalsFetcher, animalStore: AnimalStore) {
        self.animalFetcher = animalFetcher
        self.animalStore = animalStore
    }
    
    var isLoading:Bool {
        loadingState == .loading
    }
    
    var isLoadingMore: Bool {
        loadingState == .isLoadingMore
    }
    
    var errorMessage: String? {
        guard case .failed(let message) = loadingState else {
            return nil
        }
        return message
    }

    
    func fetchAnimals() async {
        // prevent duplicate initial requests.
        guard !isLoading, !isInitialLoadingDone else { return }
       
        loadingState = .loading
        let animals = await animalFetcher.fetchAnimals(page: page, limit: 5)
        
        do{
            try await animalStore.save(animals: animals)
            loadingState = .loaded
            isMoreAnimalAvailable = !animals.isEmpty
            isInitialLoadingDone = true
        } catch {
            print("Error storing animals... \(error.localizedDescription)")
            loadingState = .failed(error.localizedDescription)
        }
        
       
    }
    
    func fetchMoreAnimals() async {
        // prevent duplicate initial requests.
        guard !isLoading, !isLoadingMore, isInitialLoadingDone, isMoreAnimalAvailable else { return }
       
        loadingState = .isLoadingMore
        let nextPage = page + 1
        let animals = await animalFetcher.fetchAnimals(page: nextPage, limit: 5)
        
        do{
            try await animalStore.save(animals: animals)
            loadingState = .loaded
            isMoreAnimalAvailable = !animals.isEmpty
            page = nextPage
           
        } catch {
            print("Error storing animals... \(error.localizedDescription)")
            loadingState = .failed(error.localizedDescription)
           
        }
        
       
    }
    
  
}
