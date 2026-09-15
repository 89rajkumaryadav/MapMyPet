//
//  PhotoSizes.swift
//  APIColors
//
//  Created by Rajkumar Yadav on 15/09/26.
//

import Foundation

struct PhotoSizes: Codable {
  var id: Int?
  var small: URL?
  var medium: URL?
  var large: URL?
  var full: URL?
}
