//
//  RequestManagerMock.swift
//  MapMyPetTests
//
//  Created by Rajkumar Yadav on 24/09/26.
//

import XCTest
@testable import MapMyPet

class RequestManagerMock: RequestManagerProtocol {
    
    let apiManager: APIManagerProtocol
    let accessTokenManager: AccessTokenManagerProtocol
    let parser: DataParserProtocol
    
    init(apiManager: APIManagerProtocol, accessTokenManager: AccessTokenManagerProtocol, parser: DataParserProtocol = DataParser()) {
        self.apiManager = apiManager
        self.accessTokenManager = accessTokenManager
        self.parser = parser
    }
    
    func perform<T: Decodable>(_ request: any RequestProtocol) async throws -> T {
        let authToken = try await requestAccessToken()
        let data = try await apiManager.perform(request, authToken: authToken)
        let decoded: T = try parser.parser(data: data)
        return decoded
    }
    
    func requestAccessToken() async throws -> String {
        if await accessTokenManager.isTokenValid(){
            return await accessTokenManager.fetchToken()
        }
        
        guard let data = AccessTokenTestHelper.generateValidToken().data(using: .utf8)else {return ""}
        let token: APIToken = try await parser.parser(data: data)
        try await accessTokenManager.refreshWith(apiToken: token)
        return await token.bearerAccessToken
    }
    
}
