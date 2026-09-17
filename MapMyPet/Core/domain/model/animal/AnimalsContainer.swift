//
//  AnimalsContainer.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 17/09/26.
//

import Foundation

struct AnimalsContainer: Decodable {
  let animals: [Animal]
  let pagination: Pagination
}
