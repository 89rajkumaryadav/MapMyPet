//
//  RequestManagerTests.swift
//  MapMyPetTests
//
//  Created by Rajkumar Yadav on 24/09/26.
//

import XCTest
@testable import MapMyPet

class RequestManagerTests: XCTestCase {
    private var requestManager: RequestManagerProtocol?
    override func setUp() async throws {
        guard let userDefaults = UserDefaults(suiteName: #file) else { return }
        userDefaults.removePersistentDomain(forName: #file)
        requestManager = RequestManager(
            apiManager: APIManagerMock(),
            accessTokenManager: AccessTokenManager(userDefaults: userDefaults)
        )
    }
    
    func testRequestAnimals() async throws {
        guard let container: AnimalsContainer =
                try await requestManager?.perform(AnimalsRequestMock.getAnimalsWith) else{
            XCTFail("Didm't get data from the request manager")
            return
        }
        
        let animals = await container.data
        
        let first = animals.first
        let last = animals.last
        
            let firstName = await first?.name
            let firstSex = await first?.attributes.sex
            let firstAge = await first?.attributes.ageString

            let lastName = await last?.name
            let lastSex = await last?.attributes.sex
            let lastAge = await last?.attributes.ageString

            XCTAssertEqual(firstName, "Shyann")
            XCTAssertEqual(firstSex, "Female")
            XCTAssertEqual(firstAge, "19 Years 9 Months")

            XCTAssertEqual(lastName, "Maxine")
            XCTAssertEqual(lastSex, "Female")
            XCTAssertNil(lastAge)
        
    }
    
    
    
    
    
    
}
