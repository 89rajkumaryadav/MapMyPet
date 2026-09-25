//
//  AccessTokenManagerTests.swift
//  MapMyPetTests
//
//  Created by Rajkumar Yadav on 24/09/26.
//

import XCTest
@testable import MapMyPet


class AccessTokenManagerTests: XCTestCase {
    
    var requestManager: RequestManagerMock?
    var accessTokenmanager: AccessTokenManagerProtocol?
    
    override func setUp() {
        super.setUp()
        guard let userDefaults = UserDefaults(suiteName: #file) else { return }
        userDefaults.removePersistentDomain(forName: #file)
        accessTokenmanager = AccessTokenManager(userDefaults: userDefaults)
        guard let accessTokenmanager = accessTokenmanager else { return }
        requestManager = RequestManagerMock(
            apiManager: APIManagerMock(), accessTokenManager: accessTokenmanager
           
        )
    }
    
    func testRequestToken() async throws {
        guard let token = try await requestManager?.requestAccessToken() else { return }
        XCTAssertFalse(token.isEmpty)
    }
    
    func testCachedToken() async throws {
        let token = try await requestManager?.requestAccessToken()
        let sameToken = accessTokenmanager?.fetchToken()
        XCTAssertEqual(token, sameToken)

    }
    
    func testRequestNewToken() async throws {
        guard let token = try await requestManager?.requestAccessToken() else { return }
        guard let accessTokenManager = accessTokenmanager else {return}
        let isvalid = await accessTokenManager.isTokenValid()
        XCTAssertTrue(isvalid)
        
        let exp = expectation(description: "Test token validity after 10 seconds")
        var result = XCTWaiter.wait(for: [exp], timeout: 10.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(accessTokenManager.isTokenValid())
            let newToken = try await requestManager?.requestAccessToken()
            XCTAssertTrue(accessTokenManager.isTokenValid())
            XCTAssertNotEqual(token, newToken)
            
        }else{
            XCTFail("Test failed.")
        }
    }
    
    func testRefreshToken()async throws {
        guard let token = try await requestManager?.requestAccessToken() else {return}
        let randomToken = AccessTokenTestHelper.randomAPIToken()
        guard let accessTokenmanager = accessTokenmanager else {return}
        try await accessTokenmanager.refreshWith(apiToken: randomToken)
        let newtoken = await accessTokenmanager.fetchToken()
        XCTAssertNotEqual(token, newtoken)
        XCTAssertEqual(randomToken.bearerAccessToken, newtoken)
    }
    
}
