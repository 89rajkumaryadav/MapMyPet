//
//  AnimalEntity.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 01/10/26.
//

import CoreData

extension AnimalEntity {
    var picture: URL?{
        attributes?.pictureThumbnailUrl
    }
    
    var name: String {
        attributes?.name ?? ""
    }
}


extension Animal: UUIDIdentifiable {
   
    
    init(managedObject: AnimalEntity){
        self.id = String(managedObject.id ?? "")
        self.type = managedObject.type
        self.attributes = AnimalsAttributes(manageObject: managedObject.attributes)
        
    }
    
    private func checkForExistingAnimal(id: Int, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> Bool {
      let fetchRequest = AnimalEntity.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "id = %d", id)

      if let results = try? context.fetch(fetchRequest), results.first != nil {
        return true
      }
      return false
    }
    
     func toManagedObject(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> AnimalEntity? {
        guard let id = self.id, let idValue = Int(id) else { return nil }
        guard checkForExistingAnimal(id: idValue, context: context) == false else { return nil }
        let persistedValue = AnimalEntity.init(context: context)
        persistedValue.id = id
        persistedValue.type = type
        persistedValue.attributes = self.attributes?.toManagedObject(context: context)
        
        return persistedValue
    }
    
}



