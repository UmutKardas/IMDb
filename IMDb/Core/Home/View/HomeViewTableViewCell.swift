//
//  HomeViewTableViewCell.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 17.10.2024.
//
import SnapKit
import UIKit

class HomeViewTableViewCell: UITableViewCell {
    static let identifier = "HomeViewTableViewCell"
    private var movies: Movie?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 165, height: 360)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "tableBackground")
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        return collectionView
    }()

    private var title: UILabel = {
        let title = UILabel()
        title.text = "Top 10 on IMDb this week"
        title.font = .systemFont(ofSize: 25, weight: .semibold)
        title.textAlignment = .left
        return title
    }()

    private var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "yellowColor")
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let showAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .right
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "tableBackground")
        collectionView.delegate = self
        collectionView.dataSource = self
        setupLayout()
        setupConstrains()
    }

    func setupCell(with movies: (String, Movie)) {
        self.movies = movies.1
        title.text = movies.0
        collectionView.reloadData()
    }

    private func setupLayout() {
        contentView.addSubview(collectionView)
        contentView.addSubview(titleView)
        contentView.addSubview(title)
        contentView.addSubview(showAllButton)
    }

    private func setupConstrains() {
        titleView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(8)
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }

        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(titleView.snp.trailing).offset(10)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }

        showAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(title.snp.centerY)
            make.trailing.equalToSuperview().offset(-10)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.data?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        if let data = movies?.data?[indexPath.row] {
            cell.setupCell(with: data, index: indexPath.row)
        }
        return cell
    }
}
