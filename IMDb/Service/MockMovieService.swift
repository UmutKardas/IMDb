//
//  MockMovieService.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 17.10.2024.
//

import Foundation
import RxCocoa
import RxSwift

final class MockMovieService: IMovieService {
    func fetchWeekTopMovies() -> RxSwift.Observable<Movie> {
        guard let path = Bundle.main.path(forResource: "movieMockData", ofType: "json") else { return Observable.error(NetworkError.invalidURL) }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return try Observable<Movie>.just(JSONDecoder().decode(Movie.self, from: data))
        }
        catch {
            return Observable.error(NetworkError.unknownError(error.localizedDescription))
        }
    }

    func fetchOscarWinnersMovies() -> RxSwift.Observable<Movie> {
        guard let path = Bundle.main.path(forResource: "mockOscarWinMoviesData", ofType: "json") else { return Observable.error(NetworkError.invalidURL) }

        do {
            let data = try Data(contentsOf: URL(filePath: path), options: .mappedIfSafe)
            return try Observable<Movie>.just(JSONDecoder().decode(Movie.self, from: data))
        }
        catch {
            return Observable.error(NetworkError.unknownError(error.localizedDescription))
        }
    }

    func searchMovies(for query: String) -> Observable<MovieSearch> {
        guard let path = Bundle.main.path(forResource: "mockSearchMovieData", ofType: "json") else { return Observable.error(NetworkError.invalidURL) }
        do {
            let data = try Data(contentsOf: URL(filePath: path), options: .mappedIfSafe)
            return try Observable<MovieSearch>.just(JSONDecoder().decode(MovieSearch.self, from: data))
        }
        catch {
            return Observable.error(NetworkError.unknownError(error.localizedDescription))
        }
    }
}
