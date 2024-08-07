//
//  SearchTableViewCell.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 02.07.24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    private var item: MovieCellProtocol? = nil
    
    private let leftImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    private let verticalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .primaryBlack
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subTitleLabel.textColor = .title
        subTitleLabel.numberOfLines = 7
        return subTitleLabel
    }()
    
    private var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
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
        ratingLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        ratingLabel.textColor = .primaryBlack
        return ratingLabel
    }()
    
    private var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .primarySurface
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        contentView.backgroundColor = .primaryWhite
        contentView.addSubview(leftImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(ratingStackView)
        contentView.addSubview(seperatorView)
        
        [ratingStarImageView,
         ratingLabel].forEach(ratingStackView.addArrangedSubview)
        
        [ titleLabel,
          subTitleLabel,
        ].forEach(verticalStackView.addArrangedSubview)
        
        
        leftImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.bottom.equalTo(seperatorView.snp.top).offset(-16)
            make.height.equalTo(200)
            make.width.equalTo(160)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(leftImageView.snp.trailing).offset(16)
        }
        
        ratingStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(leftImageView.snp.trailing).offset(16)
            make.bottom.equalTo(seperatorView.snp.top).offset(-16)
        }
        
        ratingStarImageView.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        seperatorView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.height.equalTo(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ item: MovieCellProtocol) {
        leftImageView.downloadImage(with: item.posterImage)
        titleLabel.text = item.titleText
        subTitleLabel.text = item.overViewText
        ratingLabel.text = item.ratingText
    }
}


