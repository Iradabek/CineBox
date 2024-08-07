//
//  MovieDetailsComponent.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 06.07.24.
//

import UIKit

class MovieDetailsComponent: UIView {

    private var movie: MovieDetails?
    var onFavoriteButtonTapped: ((Bool) -> Void)?
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .primaryWhite
        containerView.layer.cornerRadius = 24
        return containerView
    }()
    
    private let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 30
        return verticalStackView
    }()
    
    private let topStackView: UIStackView = {
        let topStackView = UIStackView()
        topStackView.axis = .vertical
        topStackView.spacing = 14
        return topStackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private var ratingHorizontalStackView: UIStackView = {
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
        ratingLabel.font = .systemFont(ofSize: 14, weight: .regular)
        ratingLabel.textColor = .primaryBlack
        return ratingLabel
    }()
    
    private let genreView: UIView = {
        let genreView = UIView()
        return genreView
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
        
    private let horizontalDetailsStackView: UIStackView = {
        let hsv = UIStackView()
        hsv.axis = .horizontal
        hsv.alignment = .leading
        hsv.distribution = .fillProportionally
        hsv.spacing = 16
        return hsv
    }()
    
    private let lengthStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    private let lengthLabel: UILabel = {
        let label = UILabel()
        label.text = "Length"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let lengthNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let languageStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let languageDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let dateStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Release date"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let dateDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var addToWatchlistButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Add to Watchlist", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .primaryYellow
        button.addTarget(self, action: #selector(didTapAddToWatchlistButton), for: .touchUpInside)
        return button
    }()
    
    private let descriptionStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "About Movie"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let descriptionsubtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        return subtitleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        addSubview(containerView)
        containerView.addSubview(verticalStackView)
        
        [topStackView,descriptionStackView].forEach(verticalStackView.addArrangedSubview)
        
        [titleLabel,ratingHorizontalStackView, genresLabel,horizontalDetailsStackView, addToWatchlistButton].forEach(topStackView.addArrangedSubview)
        
        [ratingStarImageView, ratingLabel].forEach(ratingHorizontalStackView.addArrangedSubview)
        
        [descriptionTitleLabel, descriptionsubtitleLabel].forEach(descriptionStackView.addArrangedSubview)
        
        [lengthStackView,languageStackView, dateStackView].forEach(horizontalDetailsStackView.addArrangedSubview)
        
        [lengthLabel, lengthNumberLabel].forEach(lengthStackView.addArrangedSubview)
        
        [languageLabel, languageDetailLabel].forEach(languageStackView.addArrangedSubview)
        
        [dateLabel, dateDetailLabel].forEach(dateStackView.addArrangedSubview)
        
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        
        addToWatchlistButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        ratingStarImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: MovieDetailsProtocol) {
        titleLabel.text = movie.titleText
        ratingLabel.text = "\(movie.ratingText)"
        lengthNumberLabel.text = "\(movie.runtimeText) min"
        languageDetailLabel.text = movie.originalLanguageText
        dateDetailLabel.text = movie.releaseDateText
        descriptionsubtitleLabel.text = movie.overViewText
        genresLabel.text = (movie.genreItems.joined(separator: " , "))
        self.movie = movie as? MovieDetails
        updateWatchlistButton()
    }
    
    func updateWatchlistButton() {
        guard let movie = movie else { return }
        let isInWatchlist = WatchlistManager.shared.watchlistMovies.contains(where: { $0.id == movie.id })
        
        if isInWatchlist {
            addToWatchlistButton.setTitle(" ✔ Added to Watchlist", for: .normal)
            addToWatchlistButton.setTitleColor(.white, for: .normal)
            addToWatchlistButton.backgroundColor = .lightGray
        } else {
            addToWatchlistButton.setTitle(" + Add to Watchlist", for: .normal)
            addToWatchlistButton.setTitleColor(.black, for: .normal)
            addToWatchlistButton.backgroundColor = .primaryYellow
        }
    }
    
    @objc
    private func didTapAddToWatchlistButton() {
        guard let movie = movie else { return }
        if WatchlistManager.shared.isMovieInWatchlist(movie) {
            WatchlistManager.shared.removeMovieFromWatchlist(movie)
        } else {
            WatchlistManager.shared.addMovieToWatchlist(movie)
        }
        updateWatchlistButton()
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}



