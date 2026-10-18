//
//  Animal.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 16/09/26.
//

import Foundation

struct Animal: Codable {
    var id: String?
    var type: String?
    var attributes: AnimalsAttributes?
}

struct AnimalsAttributes: Codable {
    var name: String?
    var sex: String?
    var breedString: String?
    var ageGroup: Age?
    var ageString: String?
    var descriptionText: String?
    var pictureCount: Int?
    var url: URL?
    var pictureThumbnailUrl: URL?
    
}


extension Animal: Identifiable {}
                                     
