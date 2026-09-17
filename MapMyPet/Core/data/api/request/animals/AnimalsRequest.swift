//
//  AnimalsRequest.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 17/09/26.
//

import Foundation

enum AnimalsRequest: RequestProtocol {
    
    case getAnimalsWith(page: Int, latitude: Double?, longitude: Double?)
    
    case getAnimalsBy(name: String, age: String?, type: String?)
    
    var path: String {
        "/v2/animals"
    }
    
    var urlParams: [String : String?] {
        switch self {
            
        case let .getAnimalsWith(page: page, latitude: latitude, longitude: longitude):
            var params = ["page": String(page)]
            
            if let latitude = latitude {
                params["latitude"] = String(latitude)
            }
            
            if let longitude = longitude {
                params["longitude"] = String(longitude)
            }
            
            params["sort"] = "random"
            
            return params
            
        case let .getAnimalsBy(name, age, type):
              var params: [String: String] = [:]
              if !name.isEmpty {
                params["name"] = name
              }

              if let age = age {
                params["age"] = age
              }

              if let type = type {
                params["type"] = type
              }
              return params
            }
        
        }
    
    
    var requestType: RequestType { .GET }
    
    
}
