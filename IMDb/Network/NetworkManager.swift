//
//  NetworkManager.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 15.10.2024.
//

import Alamofire
import Foundation
import RxCocoa
import RxSwift

final class NetworkManager: NetworkManagerProtocol {
    private let config: NetworkConfig
    private let decoder: JSONDecoder

    init(config: NetworkConfig, decoder: JSONDecoder = JSONDecoder()) {
        self.config = config
        self.decoder = decoder
        self.decoder.dateDecodingStrategy = .iso8601
    }

    func send<T>(path: NetworkPath, method: NetworkMethod, type: T.Type, body: (any Encodable)?, paramater: Alamofire.Parameters?) -> Observable<T> where T: Decodable {
        let url = config.baseURL + path.path

        return Observable.create { observer in
            var request: DataRequest

            if let body = body {
                request = AF.request(
                    url,
                    method: method.method,
                    parameters: body, encoder: JSONParameterEncoder.default, headers: ApiHeader.defaultHeaders
                )
            } else {
                request = AF.request(
                    url,
                    method: method.method,
                    parameters: paramater,
                    headers: ApiHeader.defaultHeaders
                )
            }

            request.validate()
                .responseDecodable(of: T.self, decoder: self.decoder) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
