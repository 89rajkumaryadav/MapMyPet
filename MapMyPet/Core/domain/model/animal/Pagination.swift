//
//  Pagination.swift
//  APIColors
//
//  Created by Rajkumar Yadav on 15/09/26.
//

struct Pagination: Codable {
  let countPerPage: Int
  let totalCount: Int
  let currentPage: Int
  let totalPages: Int
}
