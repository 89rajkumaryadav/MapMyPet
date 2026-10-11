//
//  AnimalsAttributesMapping.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 01/10/26.
//

import CoreData


extension AnimalsAttributesEntity {
    var age: Age {
        get{
            guard let ageString = ageString, let age = Age(rawValue: ageString) else{
                return Age.unknown
            }
            return age
        }
        set{
            self.ageString = newValue.rawValue
        }
    }
}

extension AnimalsAttributes{
   
    init(manageObject: AnimalsAttributesEntity?) {
        self.name = manageObject?.name
        self.sex = manageObject?.sex
        self.breedString = manageObject?.breedString
        self.age = manageObject?.age
        self.descriptionText = manageObject?.descriptionText
        self.pictureCount = Int(manageObject?.pictureCount ?? 0)
        self.url = manageObject?.url
        self.pictureThumbnailUrl = manageObject?.pictureThumbnailUrl
    }

     func toManagedObject(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> AnimalsAttributesEntity {
       
        let managedObject = AnimalsAttributesEntity.init(context: context)
        managedObject.name = name
        managedObject.sex = sex
        managedObject.breedString = breedString
        managedObject.age = age ?? .unknown
        managedObject.descriptionText = descriptionText
        managedObject.pictureCount = Int32(self.pictureCount ?? 0)
        managedObject.url = url
        managedObject.pictureThumbnailUrl = pictureThumbnailUrl
        
       return managedObject
    }
    
}

