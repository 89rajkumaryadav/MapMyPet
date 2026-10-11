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
    
    @Published var isLoading: Bool = false
    @Published var hasMoreAnimals: Bool = true
    private let animalFetcher: AnimalsFetcher
    private let animalStore: AnimalStore

    private(set) var page = 1

    init(animalFetcher: AnimalsFetcher, animalStore: AnimalStore) {
        self.animalFetcher = animalFetcher
        self.animalStore = animalStore
    }

    func fetchAnimals() async {
        isLoading = true
        let animals = await animalFetcher.fetchAnimals(page: page, limit: 10)
        
        do{
            try await animalStore.save(animals: animals)
        } catch {
            print("Error storing animals... \(error.localizedDescription)")
        }
        isLoading = false
        hasMoreAnimals = !animals.isEmpty
    }
    
    func fetchMoreAnimals() async {
        page += 1
        await fetchAnimals()
    }
}
