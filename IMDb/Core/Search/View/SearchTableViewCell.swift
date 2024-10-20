//
//  SearchTableViewCell.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 20.10.2024.
//

import Kingfisher
import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.label.withAlphaComponent(0.65)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupConstraints()
    }

    func setupCell(with detail: Detail?) {
        titleLabel.text = detail?.title
        descriptionLabel.text = detail?.stars
        movieImage.kf.setImage(with: URL(string: detail?.image ?? ""))
    }

    private func setupLayout() {
        contentView.addSubview(movieImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        movieImage.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(50)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalTo(movieImage.snp.trailing).offset(10)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(movieImage.snp.trailing).offset(10)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
