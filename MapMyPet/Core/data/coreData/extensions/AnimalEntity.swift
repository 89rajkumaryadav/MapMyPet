//
//  AnimalEntity.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 01/10/26.
//

import CoreData

extension AnimalEntity {
   
}


extension Animal: UUIDIdentifiable {
   
    
    init(managedObject: AnimalEntity){
        self.id = String(managedObject.id ?? "")
        self.type = managedObject.type
        self.attributes = AnimalsAttributes(managedObject: managedObject.attributes)
        
    }
    
}



