//
//  AccessTokenTestHelper.swift
//  MapMyPetTests
//
//  Created by Rajkumar Yadav on 24/09/26.
//


@testable import MapMyPet

enum AccessTokenTestHelper {
    
    static func randomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String(letters.shuffled().prefix(8))
    }
    
    static func randomAPIToken() -> APIToken {
        return APIToken(tokenType: "Bearer", expiresIn: 10, accessToken: AccessTokenTestHelper.randomString())
    }
    
    static func generateValidToken() -> String {
        """
            {
              "token_type": "Bearer",
              "expires_in": 10,
              "access_token": \"\(randomString())\"
            }
        """
    }
}
