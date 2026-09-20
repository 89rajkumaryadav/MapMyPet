//
//  AnimalsRequest.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 17/09/26.
//

import Foundation

enum AnimalsRequest: RequestProtocol {
    
    case getAnimalsWith(page: Int, limit:Int = 10)

    case getAnimalsBy(name: String, age: String?, type: String?)
    
    var path: String {
        "/v5/public/animals"
    }
    
    var urlParams: [String : String?] {
        switch self {
            
        case let .getAnimalsWith(page: page, limit: limit):
            var params = ["page": String(page)]
            params["limit"] =  String(limit)
            
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
    
    var headers: [String : String] {
        [
            "Authorization": APIConstants.API_KEY,
            "Content-Type":"application/vnd.api+json"
        ]
    }
    var requestType: RequestType { .GET }
}

