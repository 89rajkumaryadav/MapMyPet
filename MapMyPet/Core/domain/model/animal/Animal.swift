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
    
    var picture: URL?{
        attributes?.pictureThumbnailUrl
    }
    
    var name: String {
        attributes?.name ?? ""
    }
}

struct AnimalsAttributes: Codable {
    var id: String?
    var name: String?
    var sex: String?
    var breedString: String?
    var ageString: String?
    var descriptionText: String?
    var pictureCount: Int?
    var url: URL?
    var pictureThumbnailUrl: URL?
    
}


extension Animal: Identifiable {}
