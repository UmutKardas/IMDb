//
//  NetworkManagerProtocol.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 15.10.2024.
//

import Alamofire
import RxCocoa
import RxSwift

protocol NetworkManagerProtocol {
    func send<T>(path: NetworkPath, method: NetworkMethod, type: T.Type, body: (any Encodable)?, paramater: Alamofire.Parameters?) -> Observable<T> where T: Decodable
}
