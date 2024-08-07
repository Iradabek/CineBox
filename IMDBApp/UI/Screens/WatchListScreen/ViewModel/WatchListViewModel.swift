//
//  WatchListViewModel.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 13.07.24.
//

import Foundation

class WatchListViewModel {
    var movieItems: [MovieDetails] = []
    var watchlistUpdated: (() -> Void)?

    func loadWatchlist() {
        movieItems = WatchlistManager.shared.watchlistMovies
        watchlistUpdated?()
    }
}
