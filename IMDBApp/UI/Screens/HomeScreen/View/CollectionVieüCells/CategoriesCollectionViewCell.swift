//
//  CategoriesCollectionViewCell.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
        
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryWhite
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()


    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .primaryBlack
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    private var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private var ratingStarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "star")
        return iv
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = .systemFont(ofSize: 10, weight: .regular)
        ratingLabel.textColor = .primaryBlack
        return ratingLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(backView)
        backView.addSubview(imageView)
        backView.addSubview(stackView)
        
        stackView.addArrangedSubview(horizontalStackView)
        stackView.addArrangedSubview(titleLabel)
        
        horizontalStackView.addArrangedSubview(ratingStarImageView)
        horizontalStackView.addArrangedSubview(ratingLabel)

        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(120)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.trailing.leading.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configure(_ item: MovieCellProtocol) {
        imageView.downloadImage(with: item.posterImage)
        titleLabel.text = item.titleText
        ratingLabel.text = item.ratingText
    }
}

    
 
