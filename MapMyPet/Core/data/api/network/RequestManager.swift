//
//  RequestManager.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 17/09/26.
//

import Foundation

protocol RequestManagerProtocol{
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}


class RequestManager: RequestManagerProtocol {
   
    
    let apiManager: APIManagerProtocol
    let parser: DataParserProtocol
    let accessTokenManager: AccessTokenManagerProtocol
    
    init(
      apiManager: APIManagerProtocol = APIManager(),
      parser: DataParserProtocol = DataParser(),
      accessTokenManager: AccessTokenManagerProtocol = AccessTokenManager()
      ) {
        self.apiManager = apiManager
        self.parser = parser
        self.accessTokenManager = accessTokenManager
      }
    
    func requestAccessToken() async throws -> String{
        if accessTokenManager.isTokenValid(){
            return accessTokenManager.fetchToken()
        }
        
        let data = try await apiManager.requestToken()
        let token: APIToken = try parser.parser(data: data)
        try accessTokenManager.refreshWith(apiToken: token)
        return token.bearerAccessToken
    }
    
    func perform<T>(_ request: any RequestProtocol) async throws -> T where T : Decodable {
       // let authToken = try await requestAccessToken()
        let data = try await apiManager.perform(request, authToken: APIConstants.API_KEY)
        let decoded: T = try parser.parser(data: data)
        return decoded
    }
    
}
