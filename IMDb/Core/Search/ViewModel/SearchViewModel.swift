//
//  SearchViewModel.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 20.10.2024.
//

import RxCocoa
import RxSwift
import UIKit

final class SearchViewModel {
    let searchData: BehaviorSubject<MovieSearch?> = BehaviorSubject(value: nil)

    private var service: IMovieService
    private let disposeBag = DisposeBag()

    init(service: IMovieService) {
        self.service = service
    }

    func searchMovies(for query: String) {
        service.searchMovies(for: query)
            .subscribe { [weak self] searchData in
                self?.searchData.onNext(searchData)
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
