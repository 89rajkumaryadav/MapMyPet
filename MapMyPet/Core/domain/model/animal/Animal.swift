//
//  Animal.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 16/09/26.
//

import Foundation

struct Animal: Codable {
    let type: String
    let id: String
    let attributes: AnimalsAttributes
    
    var picture: URL?{
        attributes.pictureThumbnailUrl
    }
    
    var name: String {
        attributes.name
    }
}

struct AnimalsAttributes: Codable {
    let name: String
    let sex: String?
    let breedString: String?
    let ageString: String?
    let descriptionText: String?
    let pictureCount: Int?
    let url: URL?
    let pictureThumbnailUrl: URL?
    
}


extension Animal: Identifiable {}
