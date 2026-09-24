//
//  APIManagerMock.swift
//  MapMyPetTests
//
//  Created by Rajkumar Yadav on 20/09/26.
//

import XCTest
@testable import MapMyPet

struct APIManagerMock: APIManagerProtocol {
    func perform(_ request: any MapMyPet.RequestProtocol, authToken: String) async throws -> Data {
        return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
    }
    
    func requestToken() async throws -> Data {
        Data(AccessTokenTestHelper.generateValidToken().utf8)
    }
    
    
}

