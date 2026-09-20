//
//  AccessTokenManager.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 19/09/26.
//

import Foundation

protocol AccessTokenManagerProtocol {
    func isTokenValid() -> Bool
    func fetchToken() -> String
    func refreshWith(apiToken: APIToken) throws
}

final class AccessTokenManager {
    private let userDefaults: UserDefaults
    private var accessToken: String?
    private var expiresAt = Date()
    
    init(userDefaults: UserDefaults = .standard){
        self.userDefaults = userDefaults
        update()
        
    }
    
    
}

// MARK: - AccessTokenManagerProtocol
extension AccessTokenManager: AccessTokenManagerProtocol {
    func fetchToken() -> String {
        guard let token = accessToken else { return "" }
        return token
    }
    
    func refreshWith(apiToken: APIToken) throws {
        let expiresAT = apiToken.expiresAt
        let token = apiToken.bearerAccessToken
        save(token: apiToken)
        self.expiresAt = expiresAT
        self.accessToken = token
    }
    
    func isTokenValid() -> Bool {
        update()
        return accessToken != nil && expiresAt.compare(Date()) == .orderedDescending
    }
}


// MARK: - Token Expiration
private extension AccessTokenManager {
    func save(token: APIToken){
        userDefaults.set(token.expiresAt.timeIntervalSince1970, forKey: AppUserDefaultsKeys.expiresAt)
        userDefaults.set(token.bearerAccessToken, forKey: AppUserDefaultsKeys.bearerAccessToken)
    }
    
    func getExpirationDate() -> Date {
        Date(timeIntervalSince1970: userDefaults.double(forKey: AppUserDefaultsKeys.expiresAt))
    }
    
    func getToken() -> String? {
        userDefaults.string(forKey: AppUserDefaultsKeys.bearerAccessToken)
    }
    
    func update(){
        accessToken = getToken()
        expiresAt = getExpirationDate()
    }
}
