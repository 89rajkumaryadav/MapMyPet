//
//  AnimalAttributes.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 15/09/26.
//

struct AnimalAttributes: Codable {
  var id: Int?
  var spayedNeutered: Bool? = false
  var houseTrained: Bool? = false
  var declawed: Bool? = false
  var specialNeeds: Bool? = false
  var shotsCurrent: Bool? = false
}
