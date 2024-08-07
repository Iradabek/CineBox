//
//  TopCollectionViewCell.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 01.07.24.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MovieSelectionDelegate?
    var movie: MovieResult?
        
    private let surfaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let verticalStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        return stackView
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 2
        return stackView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .primaryYellow
        return titleLabel
    }()
    
    private let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subTitleLabel.textColor = .white
        subTitleLabel.numberOfLines = 2
        return subTitleLabel
    }()
    
    private lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("See More", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor.primaryYellow
        button.titleLabel?.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 12).isActive = true
        button.titleLabel?.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12).isActive = true
        button.addTarget(self, action: #selector(didTapSeeMoreButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(surfaceView)
        contentView.addSubview(verticalStackView)
        [
            titleLabel,
            subTitleLabel,
        ].forEach(textStackView.addArrangedSubview)
        
        [
           textStackView,
           seeMoreButton
        ].forEach(verticalStackView.addArrangedSubview)

        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        surfaceView.snp.makeConstraints { make in
            make.edges.equalTo(imageView)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(surfaceView).inset(16)
        }
    }
    
    func configure(_ item: MovieCellProtocol) {
        imageView.downloadImage(with: item.posterImage)
        titleLabel.text = item.titleText
        subTitleLabel.text = item.overViewText
        movie = item as? MovieResult
        
    }
    
    @objc
    func didTapSeeMoreButton() {
        if let movie = movie {
            delegate?.didSelectMovie(movie)
        }
    }
}
