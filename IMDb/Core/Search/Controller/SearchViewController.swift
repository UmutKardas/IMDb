//
//  SearchViewController.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 15.10.2024.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class SearchViewController: UIViewController {
    private let viewModel: SearchViewModel = .init(service: MovieService())
    private var searchData: MovieSearch?
    private let disposeBag = DisposeBag()

    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()

    let recentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Recent", for: .normal)
        button.setTitleColor(UIColor(named: "selectedColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let advancedSearchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Advanced Search", for: .normal)
        button.setTitleColor(UIColor(named: "unselectedColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "yellowColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return tableView
    }()

    var underlineViewLeadingConstraint: Constraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTarget()
        setupLayout()
        setupConstrains()
        bindView()
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "background")
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupTarget() {
        recentButton.addTarget(self, action: #selector(didTapSegment(selectedButton:)), for: .touchUpInside)
        advancedSearchButton.addTarget(self, action: #selector(didTapSegment(selectedButton:)), for: .touchUpInside)
    }

    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(recentButton)
        view.addSubview(advancedSearchButton)
        view.addSubview(underlineView)
    }

    private func setupConstrains() {
        recentButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
        }

        advancedSearchButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentButton.snp.centerY)
            make.leading.equalTo(recentButton.snp.trailing).offset(20)
        }

        underlineView.snp.makeConstraints { make in
            make.top.equalTo(recentButton.snp.bottom).offset(2)
            make.height.equalTo(2)
            make.width.equalTo(recentButton.snp.width)
        }

        underlineView.snp.makeConstraints { make in
            underlineViewLeadingConstraint = make.leading.equalTo(recentButton.snp.leading).constraint
        }

        underlineViewLeadingConstraint.activate()

        tableView.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func bindView() {
        viewModel.searchData
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] searchData in
                guard let searchData = searchData else { return }
                self?.searchData = searchData
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }

    private func setupUnderlineView(selectedButton: UIButton) {
        underlineViewLeadingConstraint.deactivate()
        underlineView.snp.makeConstraints { make in
            underlineViewLeadingConstraint = make.leading.equalTo(selectedButton.snp.leading).constraint
        }
        underlineViewLeadingConstraint.activate()
    }

    private func setButtonBySelected(selectedButton: UIButton, unselectButton: UIButton) {
        selectedButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        selectedButton.setTitleColor(UIColor(named: "selectedColor"), for: .normal)
        unselectButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        unselectButton.setTitleColor(UIColor(named: "unselectedColor"), for: .normal)
    }

    @objc func didTapSegment(selectedButton: UIButton) {
        setupUnderlineView(selectedButton: selectedButton)

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }

        var unselectButton = selectedButton == recentButton ? advancedSearchButton : recentButton
        setButtonBySelected(selectedButton: selectedButton, unselectButton: unselectButton)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        viewModel.searchMovies(for: query)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: searchData?.data?[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
