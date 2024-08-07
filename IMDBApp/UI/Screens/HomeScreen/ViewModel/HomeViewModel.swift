//
//  HomeViewModel.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import Foundation

class HomeViewModel {
    let manager = HomeManager.shared
    var movie: Movie?
    var movieItems = [MovieResult]()
    
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    enum MovieCategories: String {
        case Popular
        case NowPlaying
        case TopRated
        case Upcoming
        case Trending
    }
    
    // Function to fetch movies based on category
    func fetchMovies(for category: MovieCategories) {
        let type: MovieCategory
        
        switch category {
        case .Popular:
            type = .popular
        case .NowPlaying:
            type = .nowPlaying
        case .TopRated:
            type = .topRated
        case .Upcoming:
            type = .upcoming
        case .Trending:
            type = .trending
        }
        
        manager.getCategoryMovies(type: type, page: (movie?.page ?? 0) + 1) { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.movie = movie
                if let movieItems = movie?.results, !movieItems.isEmpty {
                    self?.movieItems.append(contentsOf: movieItems)
                }
                self?.successCallback?()
            }
        }
    }
}

