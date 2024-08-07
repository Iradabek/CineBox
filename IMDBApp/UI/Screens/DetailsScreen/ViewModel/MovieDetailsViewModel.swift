//
//  MovieDetailsViewModel.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 06.07.24.
//

import Foundation

enum MovieListType {
    case movie
}

class MovieDetailsViewModel {
    let id: Int?
    var item: MovieDetails? 

    var successCallback: (() -> Void)?
    var errorCallback: ((String) -> Void)?
    
    init(id: Int? = nil, type: MovieListType? = nil) {
        self.id = id
        
        switch type {
        case .movie:
            getMovieItemDetails()
        case .none:
            break
        }
    }
    
    func getMovieItemDetails() {
        MovieDetailsManager.shared.getMovieDetails(id: id ?? 0) { [weak self] movieDetails, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else if let movieDetails = movieDetails {
                self?.item = movieDetails
                self?.successCallback?()
            }
        }
    }
}


