//
//  HomeViewModel.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 17.10.2024.
//

import RxCocoa
import RxSwift
import UIKit

final class HomeViewModel {
    let weekMoviesData: BehaviorSubject<Movie?> = BehaviorSubject(value: nil)
    let oscarMoviesData: BehaviorSubject<Movie?> = BehaviorSubject(value: nil)
    private let disposeBag = DisposeBag()

    var service: IMovieService

    init(service: IMovieService) {
        self.service = service
        fetchWeekMovies()
        fetchOscarMovies()
    }

    private func fetchWeekMovies() {
        service.fetchWeekTopMovies()
            .subscribe { [weak self] movies in
                self?.weekMoviesData.onNext(movies)
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }

    private func fetchOscarMovies() {
        service.fetchOscarWinnersMovies()
            .subscribe { [weak self] movies in
                self?.oscarMoviesData.onNext(movies)
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
