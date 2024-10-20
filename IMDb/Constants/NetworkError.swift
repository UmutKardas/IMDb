//
//  NetworkError.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 17.10.2024.
//

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unknownError(String)
}
