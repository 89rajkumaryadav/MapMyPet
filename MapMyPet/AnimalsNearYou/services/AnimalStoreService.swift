//
//  AnimalStoreService.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 11/10/26.
//

import Foundation
import CoreData

struct AnimalStoreService {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}


// MARK: - Animal Store
extension AnimalStoreService: AnimalStore {
    func save(animals: [Animal]) async throws {
        for animal in animals {
          _ =  animal.toManagedObject(context: context)
        }
        try context.save()
    }
}
