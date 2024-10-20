//
//  ApiHeader.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 17.10.2024.
//

import Alamofire

enum ApiHeader {
    static var defaultHeaders: HTTPHeaders {
        return [
            "x-rapidapi-key": "d058c4112cmsh524a5e93033cb97p1d6558jsn66fa21f157e7",
            "x-rapidapi-host": "imdb188.p.rapidapi.com"
        ]
    }
}
