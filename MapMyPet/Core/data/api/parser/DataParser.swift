//
//  DataParser.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 17/09/26.
//

import Foundation

protocol DataParserProtocol {
    func parser<T: Decodable>(data: Data) throws -> T
}


class DataParser: DataParserProtocol{
    
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func parser<T>(data: Data) throws -> T where T : Decodable {
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    
}
