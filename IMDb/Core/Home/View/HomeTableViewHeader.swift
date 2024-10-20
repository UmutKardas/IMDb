//
//  HomeTableViewHeader.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 17.10.2024.
//

import SnapKit
import UIKit

class HomeTableViewHeader: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What to watch"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30)
        label.textColor = UIColor(named: "titleText")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstrains()
    }

    private func setupLayout() {
        addSubview(titleLabel)
    }

    private func setupConstrains() {
        snp.makeConstraints { make in
            make.height.equalTo(40)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
