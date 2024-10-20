//
//  IMovieService.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 17.10.2024.
//

import RxCocoa
import RxSwift

protocol IMovieService {
    func fetchWeekTopMovies() -> Observable<Movie>
    func fetchOscarWinnersMovies() -> Observable<Movie>
    func searchMovies(for query: String) -> Observable<MovieSearch>
}
