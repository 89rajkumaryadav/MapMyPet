//
//  AnimalsAttributesMapping.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 01/10/26.
//

import CoreData

extension AnimalsAttributes: CoreDataMappable{
   
    typealias ManagedType = AnimalsAttributesEntity
    
    var keyMap: [PartialKeyPath<AnimalsAttributes> : String] {
        [
            \.name: "name",
            \.sex: "sex",
            \.breedString: "breedString",
            \.ageString: "ageString",
            \.descriptionText: "descriptionText",
            \.pictureCount: "pictureCount",
            \.url: "url",
            \.pictureThumbnailUrl: "pictureThumbnailUrl",
            
            
        ]
    }
    
   
}

