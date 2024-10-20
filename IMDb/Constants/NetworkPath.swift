//
//  NetworkPath.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 16.10.2024.
//

enum NetworkPath {
    case getWeekTop10
    case searchIMDB(query: String)

    var path: String {
        switch self {
        case .getWeekTop10:
            return "getWeekTop10"
        case .searchIMDB(let query):
            return "searchIMDB?query=\(query)"
        }
    }
}
