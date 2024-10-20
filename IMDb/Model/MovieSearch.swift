//
//  MovieSearch.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 20.10.2024.
//

import Foundation

// MARK: - MovieSearch

struct MovieSearch: Codable {
    let status: Bool?
    let message: String?
    let timestamp: Int?
    let data: [Detail]?
}

// MARK: - Datum

struct Detail: Codable {
    let id, title, stars: String?
    let image: String?
    let qid: String?
    let year: Int?
    let q: String?
}
