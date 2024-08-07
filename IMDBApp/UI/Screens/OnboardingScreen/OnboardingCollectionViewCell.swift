//
//  OnboardingCollectionViewCell.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 18.07.24.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    private let centerStackView: UIStackView = {
        let centerStackView = UIStackView()
        centerStackView.axis = .vertical
        centerStackView.spacing = 16
        centerStackView.alignment = .center
        return centerStackView
    }()
    
    let centerImageView: UIImageView = {
        let centerImageView = UIImageView()
        return centerImageView
    }()
    
    private let textStackView: UIStackView = {
        let textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.spacing = 4
        return textStackView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .lightGray
        subtitleLabel.textAlignment = .center
        return subtitleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(centerStackView)
        [centerImageView,textStackView].forEach(centerStackView.addArrangedSubview)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        
        centerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        centerImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
        }
    }
    
    func configure(item: OnboardingModel) {
        centerImageView.image = UIImage(named: item.image)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}

