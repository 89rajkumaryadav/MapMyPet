//
//  AnimalsContainer.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 17/09/26.
//

import Foundation

struct AnimalsContainer: Codable {
    let meta: Meta
    let data: [Animal]
}

struct Meta: Codable {
    let count: Int
    let countReturned: Int
    let pageReturned: Int
    let limit: Int
    let pages: Int
    let transactionId: String
}

