//
//  NetworkError.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 16/09/26.
//

import Foundation

public enum NetworkError: LocalizedError {
    case invalidServerResponse
    case invalidURL
    public var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "The server returned an invalid response."
            
        case .invalidURL:
            return "URL string is malformed."
        }
    }
}
