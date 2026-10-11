//
//  FetchAnimalsService.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 11/10/26.
//

import Foundation

struct FetchAnimalsService {
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}


// MARK: - Animal Fetcher

extension FetchAnimalsService: AnimalsFetcher {
    func fetchAnimals(page: Int, limit: Int = 10) async -> [Animal] {
        let requestData = AnimalsRequest.getAnimalsWith(page: page, limit: limit)
        
        do {
            let animalsContainer: AnimalsContainer = try await requestManager.perform(requestData)
            return animalsContainer.data
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
}
