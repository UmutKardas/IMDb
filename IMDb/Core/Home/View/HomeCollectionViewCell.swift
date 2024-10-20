//
//  HomeCollectionViewCell.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 17.10.2024.
//

import Kingfisher
import SnapKit
import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let archiveButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(image, for: .normal)
        return button
    }()

    private let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.textColor = UIColor.label.withAlphaComponent(0.7)
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()

    private let imdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        return imageView
    }()

    private let imdbLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "9.0"
        label.textColor = UIColor.label.withAlphaComponent(0.65)
        label.font = .systemFont(ofSize: 15, weight: .regular)

        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The Shawshank Redemption"
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "segmentBackground")
        setupLayer()
        setupLayout()
        setupConstraints()
    }

    func setupCell(with data: Datum, index: Int) {
        titleLabel.text = data.originalTitleText?.text ?? ""
        indexLabel.text = "\(index + 1)"
        imdbLabel.text = "\(data.ratingsSummary?.aggregateRating ?? 0.0)"

        imageView.kf.setImage(with: URL(string: data.primaryImage?.imageURL ?? ""))
    }

    private func setupLayer() {
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 3
    }

    private func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(archiveButton)
        contentView.addSubview(indexLabel)
        contentView.addSubview(imdbImageView)
        contentView.addSubview(imdbLabel)
        contentView.addSubview(titleLabel)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().inset(45)
            make.horizontalEdges.equalToSuperview()
        }

        archiveButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.leading.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(8)
        }

        indexLabel.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.leading.equalToSuperview().inset(5)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }

        imdbImageView.snp.makeConstraints { make in
            make.height.width.equalTo(15)
            make.leading.equalToSuperview().inset(5)
            make.top.equalTo(indexLabel.snp.bottom).offset(10)
        }

        imdbLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imdbImageView)
            make.leading.equalTo(imdbImageView.snp.trailing).offset(5)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imdbImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(5)
            make.width.equalTo(100)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
