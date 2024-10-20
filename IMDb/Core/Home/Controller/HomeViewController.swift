//
//  HomeViewController.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 15.10.2024.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class HomeViewController: UIViewController {
    private var viewModel: HomeViewModel = .init(service: MockMovieService())

    private var movieList: [(String, Movie)] = []
    private let disposeBag = DisposeBag()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeViewTableViewCell.self, forCellReuseIdentifier: HomeViewTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        movieList.removeAll()
        setupLayout()
        setupConstrains()
        bindView()
    }

    private func setupLayout() {
        view.addSubview(tableView)
        tableView.tableHeaderView = HomeTableViewHeader()
    }

    private func setupConstrains() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func bindView() {
        viewModel.weekMoviesData
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] movies in
                guard let movies = movies else { return }
                self?.movieList.append(("Top 10 on IMDb this week", movies))
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)

        viewModel.oscarMoviesData
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] movies in
                guard let movies = movies else { return }
                self?.movieList.append(("Oscar Winners", movies))
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableViewCell.identifier, for: indexPath) as? HomeViewTableViewCell else { return UITableViewCell() }

        cell.setupCell(with: movieList[indexPath.section])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 440
    }
}
