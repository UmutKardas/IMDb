//
//  MovieService.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 16.10.2024.
//

import Foundation
import RxCocoa
import RxSwift

final class MovieService: IMovieService {
    private let networkManager: NetworkManagerProtocol = NetworkManager(config: NetworkConfig(baseURL: "https://imdb188.p.rapidapi.com/api/v1/"), decoder: JSONDecoder())

    func fetchWeekTopMovies() -> Observable<Movie> {
        return networkManager.send(path: NetworkPath.getWeekTop10, method: .GET, type: Movie.self, body: nil, paramater: nil)
    }

    func fetchOscarWinnersMovies() -> Observable<Movie> {
        return networkManager.send(path: NetworkPath.getWeekTop10, method: .GET, type: Movie.self, body: nil, paramater: nil)
    }

    func searchMovies(for query: String) -> Observable<MovieSearch> {
        return networkManager.send(path: NetworkPath.searchIMDB(query: query), method: .GET, type: MovieSearch.self, body: nil, paramater: nil)
    }
}
