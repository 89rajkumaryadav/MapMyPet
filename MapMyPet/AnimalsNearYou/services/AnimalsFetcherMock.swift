//
//  AnimalsFetcherMock.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 11/10/26.
//

import Foundation

struct AnimalsFetcherMock: AnimalsFetcher{
    func fetchAnimals(page: Int, limit: Int) async -> [Animal] {
        Animal.mock
    }
    
    
}
