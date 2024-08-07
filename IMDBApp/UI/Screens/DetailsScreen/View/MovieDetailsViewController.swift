//
//  MovieDetailsViewController.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 06.07.24.
//

import UIKit

class MovieDetailsViewController: UIViewController, CustomNavigationBarDelegate{
    
    private let containerView = MovieDetailsComponent()
    private var vm = MovieDetailsViewModel()
    
    let navigationBarView: CustomNavigationBarView = {
        let nv = CustomNavigationBarView()
        nv.configure(.init(leftTitleText: nil, titleText: "Movie Details", isHideButton: false))
        nv.backgroundColor = .primaryWhite
        return nv
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .primaryWhite
        return contentView
    }()
    
    private let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryWhite
        view.addSubview(navigationBarView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        navigationBarView.delegate = self
        setupLayout()
        
        vm.successCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        
        vm.errorCallback = { errorMessage in
            print("Error: \(errorMessage)")
        }
        
        vm.getMovieItemDetails()
    }
    
    func configure(with movieId: Int) {
        vm = MovieDetailsViewModel(id: movieId, type: .movie)
    }
    
    func didTapBackButton() {
         navigationController?.popViewController(animated: true)
     }
    
    private func updateUI() {
        if let movie = vm.item {
            topImageView.downloadImage(with: movie.posterImage)
            containerView.configure(with: movie as MovieDetailsProtocol)
            containerView.onFavoriteButtonTapped = {  isFavorite in
                if isFavorite {
                    WatchlistManager.shared.addMovieToWatchlist(movie)
                } else {
                    WatchlistManager.shared.removeMovieFromWatchlist(movie)
                }
            }
        }
    }
}

private extension MovieDetailsViewController {
    func setupLayout() {
        prepareScrollView()
        addContentToScrollView()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationBarView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(4)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
    }

    func prepareScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func addContentToScrollView() {
        contentView.addSubview(topImageView)
        contentView.addSubview(containerView)
        
        topImageView.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.height.equalTo(400)
        }
        
        containerView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(topImageView.snp.bottom).offset(-32)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
