//
//  AnimalsRequestMock.swift
//  MapMyPetTests
//
//  Created by Rajkumar Yadav on 24/09/26.
//

import Foundation
@testable import MapMyPet

enum AnimalsRequestMock: RequestProtocol {
    
    case getAnimalsWith
    
    var path: String {
        guard let path = Bundle.main.path(forResource: "AnimalsMock", ofType: "json") else { return "" }
        return path
    }
    
    var requestType: MapMyPet.RequestType{
        .GET
    }
    
    
}
